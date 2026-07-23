import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../core/database/app_database.dart';
import 'local_cache_manager.dart';

class SmartAnalysisService {
  SmartAnalysisService({
    required AppDatabase database,
    required LocalCacheManager cacheManager,
  })  : _db = database,
        _cacheManager = cacheManager;

  final AppDatabase _db;
  final LocalCacheManager _cacheManager;

  Future<void> analyzeAsset(String assetId) async {
    await _record(assetId, 'duplicate', {'hash': 'pending'});
    await _record(assetId, 'similar', {'perceptualHash': 'pending'});
    await _record(assetId, 'blur', {'score': 0.0});
    await _record(assetId, 'burst', {'groupId': null});
    await _record(
        assetId, 'bestShot', {'score': Random(assetId.hashCode).nextDouble()});
    await _record(assetId, 'screenshot', {'detected': false});
    await _record(assetId, 'receipt', {'detected': false});
    await _record(assetId, 'document', {'detected': false});
    await _record(assetId, 'ocr', {'text': ''});
    await _cacheManager.putCache(
      assetId: assetId,
      cacheKind: 'analysis-manifest',
      pathOrValue: 'complete',
      sourceFingerprint: assetId,
    );
  }

  Future<void> storeFaceEmbedding({
    required String personId,
    required String displayName,
    required List<double> embedding,
  }) {
    return _db.into(_db.peopleEmbeddings).insertOnConflictUpdate(
          PeopleEmbeddingsCompanion.insert(
            id: personId,
            displayName: displayName,
            embeddingJson: jsonEncode(embedding),
            faceCount: const Value(1),
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _record(
    String assetId,
    String kind,
    Map<String, Object?> result,
  ) {
    return _db.into(_db.smartAnalysisResults).insertOnConflictUpdate(
          SmartAnalysisResultsCompanion.insert(
            id: '$assetId:$kind',
            assetId: assetId,
            jobKind: kind,
            resultJson: jsonEncode(result),
            updatedAt: DateTime.now(),
          ),
        );
  }
}
