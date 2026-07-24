import 'package:drift/drift.dart';
import 'package:photo_manager/photo_manager.dart';

import '../core/database/app_database.dart';
import 'backup_queue_service.dart';

class MediaIndexerService {
  MediaIndexerService({
    required AppDatabase database,
    required BackupQueueService backupQueue,
  })  : _db = database,
        _backupQueue = backupQueue;

  final AppDatabase _db;
  final BackupQueueService _backupQueue;

  static const int _pageSize = 200;

  /// Requests gallery access using the platform-appropriate flow.
  ///
  /// photo_manager maps this to `READ_MEDIA_IMAGES` / `READ_MEDIA_VIDEO` on
  /// Android 13+, `READ_EXTERNAL_STORAGE` on Android 12 and below, and the
  /// limited "selected photos" flow on Android 14 / iOS. The returned
  /// [PermissionState] reports `authorized`, `limited`, `denied` or
  /// `restricted`.
  Future<PermissionState> requestGalleryAccess() {
    return PhotoManager.requestPermissionExtend();
  }

  /// Scans the device gallery into the local database.
  ///
  /// Assumes access has already been granted by the caller. Rows are keyed by
  /// the stable platform asset id and written with an insert-or-update clause,
  /// so repeated (incremental) scans never create duplicates and never clobber
  /// user-owned columns (favorite / hidden / deleted / statuses / hash /
  /// place / camera). Only device-provided metadata is refreshed on re-scan.
  ///
  /// [onProgress] is invoked with `(processed, total)` as pages complete.
  /// [shouldContinue] is polled before each page; returning `false` stops the
  /// scan early (used for cancellation). Returns the number of assets written.
  Future<int> indexDeviceGallery({
    bool enqueueBackup = false,
    void Function(int processed, int total)? onProgress,
    bool Function()? shouldContinue,
  }) async {
    // A single virtual container holding every image + video on the device.
    final containers = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      hasAll: true,
      onlyAll: true,
    );
    if (containers.isEmpty) {
      onProgress?.call(0, 0);
      return 0;
    }

    final all = containers.first;
    final total = await all.assetCountAsync;
    onProgress?.call(0, total);
    if (total == 0) return 0;

    var processed = 0;
    final pageCount = (total / _pageSize).ceil();

    for (var page = 0; page < pageCount; page++) {
      if (shouldContinue != null && !shouldContinue()) break;

      final assets = await all.getAssetListPaged(page: page, size: _pageSize);
      if (assets.isEmpty) break;

      // Batched writes run on Drift's background isolate, so a page of
      // inserts never blocks the UI thread.
      await _db.batch((batch) {
        for (final asset in assets) {
          batch.insert(
            _db.mediaAssets,
            _insertFor(asset),
            onConflict: DoUpdate(
              (_) => _metadataUpdateFor(asset),
              target: [_db.mediaAssets.id],
            ),
          );
        }
      });

      if (enqueueBackup) {
        for (final asset in assets) {
          await _backupQueue.enqueue(asset.id);
        }
      }

      processed += assets.length;
      onProgress?.call(processed, total);
    }

    await _indexAlbums();
    return processed;
  }

  MediaAssetsCompanion _insertFor(AssetEntity asset) {
    final now = DateTime.now();
    return MediaAssetsCompanion.insert(
      id: asset.id,
      platformId: asset.id,
      fileName: asset.title ?? 'IMG_${asset.id}',
      mediaKind: _kindOf(asset),
      createdAt: asset.createDateTime,
      addedAt: now,
      width: asset.width,
      height: asset.height,
      sizeBytes: 0,
      folderName: Value(asset.relativePath),
      updatedAt: now,
    );
  }

  /// On conflict only device-owned metadata is refreshed; user columns
  /// (isFavorite / isHidden / isDeleted / statusesCsv / contentHash / place /
  /// camera) are intentionally omitted so an incremental rescan preserves them.
  MediaAssetsCompanion _metadataUpdateFor(AssetEntity asset) {
    return MediaAssetsCompanion(
      fileName: Value(asset.title ?? 'IMG_${asset.id}'),
      mediaKind: Value(_kindOf(asset)),
      createdAt: Value(asset.createDateTime),
      width: Value(asset.width),
      height: Value(asset.height),
      folderName: Value(asset.relativePath),
      updatedAt: Value(DateTime.now()),
    );
  }

  String _kindOf(AssetEntity asset) {
    return switch (asset.type) {
      AssetType.video => 'video',
      AssetType.image => asset.mimeType == 'image/gif' ? 'gif' : 'photo',
      _ => 'photo',
    };
  }

  /// Upserts one album row per on-device folder so the Albums tab reflects
  /// the real device layout, AND links each folder's assets into
  /// [AlbumAssets] — without this join table populated, album cards have no
  /// photos to show a cover thumbnail from or to open when tapped, even
  /// though the album's *name* is real.
  Future<void> _indexAlbums() async {
    final folders = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      hasAll: false,
    );
    if (folders.isEmpty) return;

    final now = DateTime.now();
    for (final folder in folders) {
      final albumId = 'folder:${folder.id}';
      await _db.into(_db.albums).insertOnConflictUpdate(
            AlbumsCompanion.insert(
              id: albumId,
              title: _albumTitle(folder.name),
              sourceFolder: Value(folder.name),
              isAuto: const Value(true),
              updatedAt: now,
            ),
          );

      String? coverAssetId;
      DateTime? coverCreatedAt;
      final count = await folder.assetCountAsync;
      final pageCount = (count / _pageSize).ceil();

      for (var page = 0; page < pageCount; page++) {
        final assets =
            await folder.getAssetListPaged(page: page, size: _pageSize);
        if (assets.isEmpty) break;

        await _db.batch((batch) {
          for (final asset in assets) {
            batch.insert(
              _db.albumAssets,
              AlbumAssetsCompanion.insert(
                albumId: albumId,
                assetId: asset.id,
                addedAt: now,
              ),
              mode: InsertMode.insertOrIgnore,
            );
          }
        });

        for (final asset in assets) {
          if (coverCreatedAt == null ||
              asset.createDateTime.isAfter(coverCreatedAt)) {
            coverAssetId = asset.id;
            coverCreatedAt = asset.createDateTime;
          }
        }
      }

      if (coverAssetId != null) {
        await (_db.update(_db.albums)..where((row) => row.id.equals(albumId)))
            .write(AlbumsCompanion(coverAssetId: Value(coverAssetId)));
      }
    }
  }

  String _albumTitle(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('camera')) return 'Camera';
    if (lower.contains('screenshot')) return 'Screenshots';
    if (lower.contains('download')) return 'Downloads';
    if (lower.contains('whatsapp')) return 'WhatsApp';
    if (lower.contains('telegram')) return 'Telegram';
    if (lower.contains('instagram')) return 'Instagram';
    return raw.isEmpty ? 'All Photos' : raw;
  }
}
