import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memoryvault/core/providers.dart';
import 'package:memoryvault/features/photos/gallery_index_controller.dart';
import 'package:memoryvault/features/photos/photos_screen.dart';
import 'package:memoryvault/models/gallery_asset.dart';
import 'package:memoryvault/repositories/gallery_repository.dart';
import 'package:memoryvault/services/media_indexer_service.dart';

/// Repository stub — PhotosScreen reads the provider but never calls a method
/// on it while the Photos segment (index 0) is showing.
class _FakeRepo implements GalleryRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _FakeIndexer implements MediaIndexerService {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

/// Holds a fixed [GalleryIndexState]; all intent methods are no-ops so the
/// widget can be rendered for any state without touching platform channels.
class _FakeController extends GalleryIndexController {
  _FakeController(GalleryIndexState initial)
      : super(_FakeIndexer(), _FakeRepo()) {
    state = initial;
  }

  @override
  Future<void> start() async {}
  @override
  Future<void> retry() async {}
  @override
  void cancel() {}
  @override
  Future<void> openSettings() async {}
}

Future<void> _pumpState(WidgetTester tester, GalleryIndexState state) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        galleryRepositoryProvider.overrideWithValue(_FakeRepo()),
        photosStreamProvider
            .overrideWith((ref) => Stream.value(const <GalleryAsset>[])),
        galleryIndexControllerProvider
            .overrideWith((ref) => _FakeController(state)),
      ],
      child: const MaterialApp(home: Scaffold(body: PhotosScreen())),
    ),
  );
  // Let the stream emit and the AnimatedSwitcher settle.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

void main() {
  testWidgets('permission denied → Grant access prompt', (tester) async {
    await _pumpState(
      tester,
      const GalleryIndexState(status: GalleryStatus.permissionDenied),
    );
    expect(find.text('Photo access needed'), findsOneWidget);
    expect(find.text('Grant access'), findsOneWidget);
  });

  testWidgets('permanently denied → Open settings', (tester) async {
    await _pumpState(
      tester,
      const GalleryIndexState(
        status: GalleryStatus.permissionPermanentlyDenied,
      ),
    );
    expect(find.text('Open settings'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('error → message + Retry', (tester) async {
    await _pumpState(
      tester,
      const GalleryIndexState(
        status: GalleryStatus.error,
        errorMessage: 'boom-scan-failed',
      ),
    );
    expect(find.textContaining('boom-scan-failed'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('scanning → progress text + Cancel', (tester) async {
    await _pumpState(
      tester,
      const GalleryIndexState(
        status: GalleryStatus.scanning,
        processed: 10,
        total: 100,
      ),
    );
    expect(find.textContaining('Scanning your library'), findsOneWidget);
    expect(find.textContaining('10 of 100'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('ready + empty library → No photos found + Refresh',
      (tester) async {
    await _pumpState(
      tester,
      const GalleryIndexState(status: GalleryStatus.ready),
    );
    expect(find.text('No photos found'), findsOneWidget);
    expect(find.text('Refresh Library'), findsOneWidget);
  });
}
