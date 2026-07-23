import 'package:drift/drift.dart';
import 'package:photo_manager/photo_manager.dart';

import '../core/database/app_database.dart';
import '../models/media_status.dart';
import 'backup_queue_service.dart';

class MediaIndexerService {
  MediaIndexerService({
    required AppDatabase database,
    required BackupQueueService backupQueue,
  })  : _db = database,
        _backupQueue = backupQueue;

  final AppDatabase _db;
  final BackupQueueService _backupQueue;

  Future<PermissionState> requestGalleryAccess() {
    return PhotoManager.requestPermissionExtend();
  }

  Future<void> indexDeviceGallery({bool enqueueBackup = false}) async {
    final permission = await requestGalleryAccess();
    if (!permission.hasAccess) return;

    final paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      hasAll: true,
    );

    for (final path in paths) {
      await _upsertAlbum(path);
      final assets = await path.getAssetListPaged(page: 0, size: 500);
      for (final asset in assets) {
        await _upsertAsset(asset, path.name);
        if (enqueueBackup) {
          await _backupQueue.enqueue(asset.id);
        }
      }
    }
  }

  Future<void> _upsertAlbum(AssetPathEntity path) {
    final now = DateTime.now();
    return _db.into(_db.albums).insertOnConflictUpdate(
          AlbumsCompanion.insert(
            id: 'folder:${path.name}',
            title: _albumTitle(path.name),
            sourceFolder: Value(path.name),
            isAuto: const Value(true),
            updatedAt: now,
          ),
        );
  }

  Future<void> _upsertAsset(AssetEntity asset, String folderName) async {
    final now = DateTime.now();
    final kind = switch (asset.type) {
      AssetType.video => 'video',
      AssetType.image => asset.mimeType == 'image/gif' ? 'gif' : 'photo',
      _ => 'photo',
    };

    await _db.into(_db.mediaAssets).insertOnConflictUpdate(
          MediaAssetsCompanion.insert(
            id: asset.id,
            platformId: asset.id,
            fileName: asset.title ?? 'IMG_${asset.id}',
            mediaKind: kind,
            createdAt: asset.createDateTime,
            addedAt: now,
            width: asset.width,
            height: asset.height,
            sizeBytes: 0,
            folderName: Value(folderName),
            statusesCsv: Value(MediaStatus.local.name),
            updatedAt: now,
          ),
        );

    await _db.into(_db.albumAssets).insertOnConflictUpdate(
          AlbumAssetsCompanion.insert(
            albumId: 'folder:$folderName',
            assetId: asset.id,
            addedAt: now,
          ),
        );
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
