import 'dart:math';

import 'package:drift/drift.dart';

import '../core/database/app_database.dart';

class TimelinePlaceService {
  TimelinePlaceService(this._db);

  final AppDatabase _db;

  Future<void> rebuildPlaceClusters() async {
    final rows = await (_db.select(_db.mediaAssets)
          ..where((asset) => asset.latitude.isNotNull()))
        .get();
    final buckets = <String, List<MediaAsset>>{};
    for (final asset in rows) {
      final name = _nearestKnownPlace(asset.latitude!, asset.longitude!);
      buckets.putIfAbsent(name, () => []).add(asset);
    }

    for (final entry in buckets.entries) {
      final first = entry.value.first;
      await _db.into(_db.placeClusters).insertOnConflictUpdate(
            PlaceClustersCompanion.insert(
              id: entry.key.toLowerCase().replaceAll(' ', '-'),
              name: entry.key,
              latitude: first.latitude!,
              longitude: first.longitude!,
              assetCount: Value(entry.value.length),
            ),
          );
    }
  }

  String _nearestKnownPlace(double latitude, double longitude) {
    final known = {
      'Rajshahi': const Point(24.3745, 88.6042),
      'Dhaka': const Point(23.8103, 90.4125),
      'Cox\'s Bazar': const Point(21.4272, 92.0058),
      'Vietnam': const Point(14.0583, 108.2772),
    };

    return known.entries
        .map(
          (entry) => MapEntry(
            entry.key,
            pow(latitude - entry.value.x, 2) +
                pow(longitude - entry.value.y, 2),
          ),
        )
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;
  }
}
