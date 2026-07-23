import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class MediaAssets extends Table {
  TextColumn get id => text()();
  TextColumn get platformId => text().unique()();
  TextColumn get fileName => text()();
  TextColumn get mediaKind => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get addedAt => dateTime()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();
  IntColumn get sizeBytes => integer()();
  TextColumn get folderName => text().nullable()();
  TextColumn get cameraMake => text().nullable()();
  TextColumn get cameraModel => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get placeName => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get statusesCsv => text().withDefault(const Constant('local'))();
  TextColumn get contentHash => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Albums extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get sourceFolder => text().nullable()();
  TextColumn get coverAssetId => text().nullable()();
  BoolColumn get isAuto => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AlbumAssets extends Table {
  TextColumn get albumId => text()();
  TextColumn get assetId => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {albumId, assetId};
}

class TimelineBuckets extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime()();
  IntColumn get assetCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class PlaceClusters extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get country => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  IntColumn get assetCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class PeopleEmbeddings extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get embeddingJson => text()();
  IntColumn get faceCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SmartAnalysisResults extends Table {
  TextColumn get id => text()();
  TextColumn get assetId => text()();
  TextColumn get jobKind => text()();
  TextColumn get resultJson => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CacheRecords extends Table {
  TextColumn get id => text()();
  TextColumn get assetId => text()();
  TextColumn get cacheKind => text()();
  TextColumn get pathOrValue => text()();
  TextColumn get sourceFingerprint => text()();
  IntColumn get schemaVersion => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BackupJobs extends Table {
  TextColumn get id => text()();
  TextColumn get assetId => text()();
  TextColumn get state => text()();
  TextColumn get remotePath => text().nullable()();
  TextColumn get errorMessage => text().nullable()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SharedAlbums extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get ownerName => text()();
  TextColumn get partnerName => text().nullable()();
  TextColumn get manifestPath => text()();
  BoolColumn get isJoined => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SharedComments extends Table {
  TextColumn get id => text()();
  TextColumn get sharedAlbumId => text()();
  TextColumn get assetId => text()();
  TextColumn get authorName => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SharedReactions extends Table {
  TextColumn get id => text()();
  TextColumn get sharedAlbumId => text()();
  TextColumn get assetId => text()();
  TextColumn get authorName => text()();
  TextColumn get reaction => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class InviteIdentities extends Table {
  TextColumn get id => text()();
  TextColumn get inviteCode => text()();
  TextColumn get role => text()();
  TextColumn get displayName => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class RecycleBinEntries extends Table {
  TextColumn get assetId => text()();
  DateTimeColumn get deletedAt => dateTime()();
  TextColumn get originalAlbumIdsCsv => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {assetId};
}

@DriftDatabase(
  tables: [
    MediaAssets,
    Albums,
    AlbumAssets,
    TimelineBuckets,
    PlaceClusters,
    PeopleEmbeddings,
    SmartAnalysisResults,
    CacheRecords,
    BackupJobs,
    SharedAlbums,
    SharedComments,
    SharedReactions,
    InviteIdentities,
    RecycleBinEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MediaAsset>> latestAssets({int limit = 200}) {
    return (select(mediaAssets)
          ..where((asset) => asset.isDeleted.equals(false))
          ..orderBy([(asset) => OrderingTerm.desc(asset.createdAt)])
          ..limit(limit))
        .get();
  }

  Stream<List<MediaAsset>> watchLatestAssets() {
    return (select(mediaAssets)
          ..where((asset) => asset.isDeleted.equals(false))
          ..orderBy([(asset) => OrderingTerm.desc(asset.createdAt)]))
        .watch();
  }

  Stream<List<BackupJob>> watchBackupJobs() {
    return (select(backupJobs)
          ..orderBy([(job) => OrderingTerm.desc(job.updatedAt)]))
        .watch();
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'memoryvault',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
  );
}
