import 'package:flutter_test/flutter_test.dart';
import 'package:memoryvault/models/gallery_asset.dart';
import 'package:memoryvault/models/media_status.dart';

void main() {
  test('asset orientation helpers are derived from dimensions', () {
    final portrait = GalleryAsset(
      id: '1',
      platformId: '1',
      fileName: 'portrait.jpg',
      kind: MediaKind.photo,
      createdAt: DateTime(2026, 7, 24),
      addedAt: DateTime(2026, 7, 24),
      width: 3024,
      height: 4032,
      sizeBytes: 1,
    );

    expect(portrait.isPortrait, isTrue);
    expect(portrait.isLandscape, isFalse);
  });

  test('new assets default to local status', () {
    final asset = GalleryAsset(
      id: '2',
      platformId: '2',
      fileName: 'local.jpg',
      kind: MediaKind.photo,
      createdAt: DateTime(2026, 7, 24),
      addedAt: DateTime(2026, 7, 24),
      width: 4032,
      height: 3024,
      sizeBytes: 1,
    );

    expect(asset.statuses, contains(MediaStatus.local));
  });
}
