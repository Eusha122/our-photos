import 'package:drift/drift.dart';

import '../core/database/app_database.dart';

class LocalCacheManager {
  LocalCacheManager(this._db);

  final AppDatabase _db;
  static const int schemaVersion = 1;

  Future<void> putCache({
    required String assetId,
    required String cacheKind,
    required String pathOrValue,
    required String sourceFingerprint,
  }) {
    final id = '$assetId:$cacheKind';
    return _db.into(_db.cacheRecords).insertOnConflictUpdate(
          CacheRecordsCompanion.insert(
            id: id,
            assetId: assetId,
            cacheKind: cacheKind,
            pathOrValue: pathOrValue,
            sourceFingerprint: sourceFingerprint,
            schemaVersion: schemaVersion,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<CacheRecord?> getFreshCache({
    required String assetId,
    required String cacheKind,
    required String sourceFingerprint,
  }) {
    return (_db.select(_db.cacheRecords)
          ..where(
            (row) =>
                row.id.equals('$assetId:$cacheKind') &
                row.sourceFingerprint.equals(sourceFingerprint) &
                row.schemaVersion.equals(schemaVersion),
          ))
        .getSingleOrNull();
  }
}
