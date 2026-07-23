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

  Future<void> moveToRecycleBin(String assetId) async {
    final now = DateTime.now();
    await _db.transaction(() async {
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
