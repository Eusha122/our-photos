import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';
import '../repositories/gallery_repository.dart';
import '../services/backblaze_b2_service.dart';
import '../services/backup_queue_service.dart';
import '../services/local_cache_manager.dart';
import '../services/media_indexer_service.dart';
import '../services/shared_invite_service.dart';
import '../services/smart_analysis_service.dart';
import '../services/timeline_place_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final galleryRepositoryProvider = Provider<GalleryRepository>((ref) {
  return GalleryRepository(ref.watch(databaseProvider));
});

final b2ServiceProvider = Provider<BackblazeB2Service>((ref) {
  return BackblazeB2Service();
});

final cacheManagerProvider = Provider<LocalCacheManager>((ref) {
  return LocalCacheManager(ref.watch(databaseProvider));
});

final backupQueueProvider = Provider<BackupQueueService>((ref) {
  return BackupQueueService(
    database: ref.watch(databaseProvider),
    b2: ref.watch(b2ServiceProvider),
    cacheManager: ref.watch(cacheManagerProvider),
  );
});

final mediaIndexerProvider = Provider<MediaIndexerService>((ref) {
  return MediaIndexerService(
    database: ref.watch(databaseProvider),
    backupQueue: ref.watch(backupQueueProvider),
  );
});

final placeServiceProvider = Provider<TimelinePlaceService>((ref) {
  return TimelinePlaceService(ref.watch(databaseProvider));
});

final smartAnalysisProvider = Provider<SmartAnalysisService>((ref) {
  return SmartAnalysisService(
    database: ref.watch(databaseProvider),
    cacheManager: ref.watch(cacheManagerProvider),
  );
});

final inviteServiceProvider = Provider<SharedInviteService>((ref) {
  return SharedInviteService();
});
