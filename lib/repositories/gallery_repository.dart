import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import '../core/database/app_database.dart';
import '../models/gallery_asset.dart' as domain;
import '../models/media_status.dart';
import '../models/timeline_bucket.dart' as domain;

class GalleryRepository {
  GalleryRepository(this._db);

  final AppDatabase _db;

  Stream<List<domain.GalleryAsset>> watchPhotos() {
    return _db.watchLatestAssets().map((rows) => rows.map(_mapAsset).toList());
  }

  Stream<List<BackupJob>> watchBackupJobs() => _db.watchBackupJobs();

  Future<void> toggleFavorite(String assetId, bool isFavorite) {
    return (_db.update(_db.mediaAssets)..where((row) => row.id.equals(assetId)))
        .write(MediaAssetsCompanion(isFavorite: Value(isFavorite)));
  }

  Future<void> moveToRecycleBin(String assetId) =>
      moveMultipleToRecycleBin([assetId]);

  /// Soft-deletes several assets at once (multi-select delete) — same
  /// per-item logic as [moveToRecycleBin], batched in one transaction.
  Future<void> moveMultipleToRecycleBin(List<String> assetIds) async {
    if (assetIds.isEmpty) return;
    final now = DateTime.now();
    await _db.transaction(() async {
      for (final assetId in assetIds) {
        await (_db.update(_db.mediaAssets)
              ..where((row) => row.id.equals(assetId)))
            .write(
          MediaAssetsCompanion(
            isDeleted: const Value(true),
            updatedAt: Value(now),
          ),
        );
        await _db.into(_db.recycleBinEntries).insertOnConflictUpdate(
              RecycleBinEntriesCompanion.insert(
                assetId: assetId,
                deletedAt: now,
              ),
            );
      }
    });
  }

  /// Everything currently in the trash, most recently deleted first.
  Stream<List<domain.GalleryAsset>> watchTrash() {
    final query = _db.select(_db.mediaAssets)
      ..where((row) => row.isDeleted.equals(true))
      ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)]);
    return query.watch().map((rows) => rows.map(_mapAsset).toList());
  }

  /// Brings an asset back out of the trash.
  Future<void> restoreFromTrash(String assetId) async {
    await _db.transaction(() async {
      await (_db.update(_db.mediaAssets)
            ..where((row) => row.id.equals(assetId)))
          .write(
        MediaAssetsCompanion(
          isDeleted: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await (_db.delete(_db.recycleBinEntries)
            ..where((row) => row.assetId.equals(assetId)))
          .go();
    });
  }

  /// Removes assets from this app's database entirely. Callers are
  /// responsible for also deleting the underlying device files first (via
  /// [MediaIndexerService.deleteFromDevice]) — this only cleans up rows so a
  /// permanent delete never leaves dangling references in albums/timeline.
  Future<void> permanentlyDeleteRows(List<String> assetIds) async {
    if (assetIds.isEmpty) return;
    await _db.transaction(() async {
      for (final assetId in assetIds) {
        await (_db.delete(_db.albumAssets)
              ..where((row) => row.assetId.equals(assetId)))
            .go();
        await (_db.delete(_db.recycleBinEntries)
              ..where((row) => row.assetId.equals(assetId)))
            .go();
        await (_db.delete(_db.mediaAssets)
              ..where((row) => row.id.equals(assetId)))
            .go();
      }
    });
  }

  Future<void> hideAsset(String assetId, bool hidden) {
    return (_db.update(_db.mediaAssets)..where((row) => row.id.equals(assetId)))
        .write(
      MediaAssetsCompanion(
        isHidden: Value(hidden),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<domain.TimelineBucket>> loadTimeline() async {
    final assets =
        (await _db.latestAssets(limit: 5000)).map(_mapAsset).toList();
    final now = DateTime.now();
    final groups = <String, List<domain.GalleryAsset>>{};

    for (final asset in assets) {
      final created = asset.createdAt;
      final title = _timelineTitle(now, created);
      groups.putIfAbsent(title, () => []).add(asset);
    }

    return groups.entries.map((entry) {
      final sorted = [...entry.value]..sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      return domain.TimelineBucket(
        title: entry.key,
        assets: sorted,
        start: sorted.last.createdAt,
        end: sorted.first.createdAt,
      );
    }).toList();
  }

  Future<List<Album>> loadAlbums() {
    return (_db.select(_db.albums)
          ..orderBy([(album) => OrderingTerm.asc(album.title)]))
        .get();
  }

  /// The real photos inside a single album, newest first — used both for the
  /// album card's cover thumbnail and for opening the full album view.
  Future<List<domain.GalleryAsset>> loadAlbumAssets(String albumId) async {
    final query = _db.select(_db.mediaAssets).join([
      innerJoin(
        _db.albumAssets,
        _db.albumAssets.assetId.equalsExp(_db.mediaAssets.id),
      ),
    ])
      ..where(_db.albumAssets.albumId.equals(albumId))
      ..where(_db.mediaAssets.isDeleted.equals(false))
      ..orderBy([OrderingTerm.desc(_db.mediaAssets.createdAt)]);
    final rows = await query.get();
    return rows
        .map((row) => _mapAsset(row.readTable(_db.mediaAssets)))
        .toList();
  }

  /// Curated groupings of real photos — replaces what used to be ten
  /// hardcoded placeholder titles with no photos behind them. Only groups
  /// that actually have at least one matching asset are returned.
  Future<List<domain.TimelineBucket>> loadMemories() async {
    final assets =
        (await _db.latestAssets(limit: 5000)).map(_mapAsset).toList();
    if (assets.isEmpty) return const [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastMonth = DateTime(now.year, now.month - 1);

    domain.TimelineBucket? bucket(
      String title,
      Iterable<domain.GalleryAsset> items,
    ) {
      final list = items.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (list.isEmpty) return null;
      return domain.TimelineBucket(
        title: title,
        assets: list,
        start: list.last.createdAt,
        end: list.first.createdAt,
      );
    }

    int daysBeforeToday(DateTime dt) =>
        today.difference(DateTime(dt.year, dt.month, dt.day)).inDays;

    final groups = <domain.TimelineBucket?>[
      bucket(
        'On This Day',
        assets.where(
          (a) =>
              a.createdAt.year != now.year &&
              a.createdAt.month == now.month &&
              a.createdAt.day == now.day,
        ),
      ),
      bucket(
        'This Week',
        assets.where((a) {
          final days = daysBeforeToday(a.createdAt);
          return days >= 0 && days <= 7;
        }),
      ),
      bucket(
        'Last Month',
        assets.where(
          (a) =>
              a.createdAt.year == lastMonth.year &&
              a.createdAt.month == lastMonth.month,
        ),
      ),
      bucket('Favorites', assets.where((a) => a.isFavorite)),
      bucket('Recently Added', assets.take(30)),
    ].whereType<domain.TimelineBucket>().toList();

    return groups;
  }

  Future<List<PlaceCluster>> loadPlaces() {
    return (_db.select(_db.placeClusters)
          ..orderBy([(place) => OrderingTerm.desc(place.assetCount)]))
        .get();
  }

  Future<List<domain.GalleryAsset>> searchOffline(String query) async {
    final normalized = query.trim().toLowerCase();
    final rows = await _db.latestAssets(limit: 10000);
    final assets = rows.map(_mapAsset).toList();
    if (normalized.isEmpty) return assets;

    return assets.where((asset) {
      final haystack = [
        asset.fileName,
        asset.folderName,
        asset.cameraMake,
        asset.cameraModel,
        asset.placeName,
        asset.kind.name,
        asset.isPortrait ? 'portrait' : 'landscape',
        if (asset.isFavorite) 'favorites',
        if (asset.isHidden) 'hidden',
        DateFormat.MMMM().format(asset.createdAt),
        DateFormat.y().format(asset.createdAt),
      ].whereType<String>().join(' ').toLowerCase();
      return haystack.contains(normalized);
    }).toList();
  }

  domain.GalleryAsset _mapAsset(MediaAsset row) {
    return domain.GalleryAsset(
      id: row.id,
      platformId: row.platformId,
      fileName: row.fileName,
      kind: MediaKind.values.firstWhere(
        (kind) => kind.name == row.mediaKind,
        orElse: () => MediaKind.photo,
      ),
      createdAt: row.createdAt,
      addedAt: row.addedAt,
      width: row.width,
      height: row.height,
      sizeBytes: row.sizeBytes,
      folderName: row.folderName,
      cameraMake: row.cameraMake,
      cameraModel: row.cameraModel,
      latitude: row.latitude,
      longitude: row.longitude,
      placeName: row.placeName,
      isFavorite: row.isFavorite,
      isHidden: row.isHidden,
      isDeleted: row.isDeleted,
      statuses: row.statusesCsv
          .split(',')
          .where((status) => status.isNotEmpty)
          .map(
            (status) => MediaStatus.values.firstWhere(
              (value) => value.name == status,
              orElse: () => MediaStatus.local,
            ),
          )
          .toSet(),
    );
  }

  String _timelineTitle(DateTime now, DateTime created) {
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(created.year, created.month, created.day);
    if (day == today) return 'Today';
    if (day == today.subtract(const Duration(days: 1))) return 'Yesterday';
    if (created.year == now.year) return DateFormat.MMMM().format(created);
    return DateFormat.y().format(created);
  }
}
