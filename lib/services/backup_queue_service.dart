import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../core/database/app_database.dart';
import '../models/media_status.dart';
import 'backblaze_b2_service.dart';
import 'local_cache_manager.dart';

class BackupQueueService {
  BackupQueueService({
    required AppDatabase database,
    required BackblazeB2Service b2,
    required LocalCacheManager cacheManager,
  })  : _db = database,
        _b2 = b2,
        _cacheManager = cacheManager;

  final AppDatabase _db;
  final BackblazeB2Service _b2;
  final LocalCacheManager _cacheManager;

  Future<void> enqueue(String assetId) async {
    final now = DateTime.now();
    await _db.into(_db.backupJobs).insertOnConflictUpdate(
          BackupJobsCompanion.insert(
            id: 'backup:$assetId',
            assetId: assetId,
            state: BackupJobState.queued.name,
            createdAt: now,
            updatedAt: now,
          ),
        );
    await _setAssetStatuses(assetId, {MediaStatus.local, MediaStatus.queued});
  }

  Future<void> processNext({
    required B2Credentials credentials,
    required Future<List<int>> Function(String assetId) readAssetBytes,
  }) async {
    final job = await (_db.select(_db.backupJobs)
          ..where((row) => row.state.equals(BackupJobState.queued.name))
          ..orderBy([(row) => OrderingTerm.asc(row.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (job == null) return;

    try {
      await _setJob(job.id, BackupJobState.thumbnail);
      await _cacheManager.putCache(
        assetId: job.assetId,
        cacheKind: 'thumbnail',
        pathOrValue: 'pending-native-thumbnail',
        sourceFingerprint: job.assetId,
      );

      await _setJob(job.id, BackupJobState.hashing);
      final bytes = await readAssetBytes(job.assetId);
      final hash = sha1.convert(bytes).toString();

      await _setJob(job.id, BackupJobState.uploading);
      await _setAssetStatuses(
        job.assetId,
        {MediaStatus.local, MediaStatus.uploading},
      );

      final remotePath =
          '${credentials.devicePrefix}/originals/${job.assetId}.bin';
      await _b2.uploadSmallFile(
        credentials: credentials,
        remotePath: remotePath,
        bytes: bytes is List<int> ? bytesFromList(bytes) : bytesFromList(bytes),
        sha1: hash,
        contentType: 'application/octet-stream',
      );

      await _setJob(job.id, BackupJobState.verifying, remotePath: remotePath);
      final verified = await _b2.verifyFile(
        credentials: credentials,
        fileName: remotePath,
      );
      if (!verified) throw StateError('Uploaded file was not found in B2.');

      await _setJob(job.id, BackupJobState.done, remotePath: remotePath);
      await _setAssetStatuses(
        job.assetId,
        {MediaStatus.local, MediaStatus.backedUp},
      );
    } catch (error) {
      await _setJob(
        job.id,
        BackupJobState.failed,
        errorMessage: error.toString(),
        attempts: job.attempts + 1,
      );
      await _setAssetStatuses(
        job.assetId,
        {MediaStatus.local, MediaStatus.failed},
      );
    }
  }

  Future<void> _setJob(
    String id,
    BackupJobState state, {
    String? remotePath,
    String? errorMessage,
    int? attempts,
  }) {
    return (_db.update(_db.backupJobs)..where((row) => row.id.equals(id)))
        .write(
      BackupJobsCompanion(
        state: Value(state.name),
        remotePath: Value(remotePath),
        errorMessage: Value(errorMessage),
        attempts: attempts == null ? const Value.absent() : Value(attempts),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _setAssetStatuses(String assetId, Set<MediaStatus> statuses) {
    return (_db.update(_db.mediaAssets)..where((row) => row.id.equals(assetId)))
        .write(
      MediaAssetsCompanion(
        statusesCsv: Value(statuses.map((status) => status.name).join(',')),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
