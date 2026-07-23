import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:photo_manager/photo_manager.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../services/media_indexer_service.dart';

/// Lifecycle of the on-device gallery scan, observed by the Photos screen.
enum GalleryStatus {
  initial,
  checkingPermission,
  permissionDenied,
  permissionPermanentlyDenied,
  scanning,
  ready,
  error,
}

class GalleryIndexState {
  const GalleryIndexState({
    this.status = GalleryStatus.initial,
    this.processed = 0,
    this.total = 0,
    this.limited = false,
    this.errorMessage,
  });

  final GalleryStatus status;
  final int processed;
  final int total;

  /// True when the OS granted access to only a user-selected subset
  /// (Android 14 "selected photos" / iOS limited).
  final bool limited;
  final String? errorMessage;

  bool get isBusy =>
      status == GalleryStatus.checkingPermission ||
      status == GalleryStatus.scanning;

  bool get needsPermission =>
      status == GalleryStatus.permissionDenied ||
      status == GalleryStatus.permissionPermanentlyDenied;

  /// Fractional progress when the total is known, otherwise null
  /// (indeterminate).
  double? get progress =>
      total > 0 ? (processed / total).clamp(0.0, 1.0) : null;

  GalleryIndexState copyWith({
    GalleryStatus? status,
    int? processed,
    int? total,
    bool? limited,
    Object? errorMessage = _noChange,
  }) {
    return GalleryIndexState(
      status: status ?? this.status,
      processed: processed ?? this.processed,
      total: total ?? this.total,
      limited: limited ?? this.limited,
      errorMessage: identical(errorMessage, _noChange)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  static const Object _noChange = Object();
}

/// Live stream of indexed photos, driven by Drift. Rebuilds the Photos screen
/// automatically as the indexer writes rows — no restart required.
final photosStreamProvider =
    StreamProvider.autoDispose<List<GalleryAsset>>((ref) {
  return ref.watch(galleryRepositoryProvider).watchPhotos();
});

final galleryIndexControllerProvider =
    StateNotifierProvider<GalleryIndexController, GalleryIndexState>((ref) {
  return GalleryIndexController(ref.watch(mediaIndexerProvider));
});

/// Owns the whole permission → index → progress → error → retry flow. The UI
/// never touches the indexer directly; it only observes [GalleryIndexState]
/// and calls the intent methods below.
class GalleryIndexController extends StateNotifier<GalleryIndexState> {
  GalleryIndexController(this._indexer) : super(const GalleryIndexState());

  final MediaIndexerService _indexer;

  bool _started = false;
  bool _running = false;
  bool _cancelled = false;

  /// Called once after the first frame. Idempotent — safe to call again.
  Future<void> start() async {
    if (_started) return;
    _started = true;
    await _run();
  }

  /// Re-run permission + scan (used by "Grant access" / "Retry" /
  /// "Refresh Library").
  Future<void> retry() => _run();

  /// Request an early stop of an in-progress scan; already-written rows stay.
  void cancel() {
    if (_running) _cancelled = true;
  }

  /// Opens the OS app-settings page (for permanently denied permission).
  Future<void> openSettings() => PhotoManager.openSetting();

  Future<void> _run() async {
    if (_running) return;
    _running = true;
    _cancelled = false;
    try {
      state = state.copyWith(
        status: GalleryStatus.checkingPermission,
        errorMessage: null,
      );

      final permission = await _indexer.requestGalleryAccess();

      if (!permission.hasAccess) {
        final permanent = await _isPermanentlyDenied();
        state = state.copyWith(
          status: permanent
              ? GalleryStatus.permissionPermanentlyDenied
              : GalleryStatus.permissionDenied,
        );
        return;
      }

      state = state.copyWith(
        status: GalleryStatus.scanning,
        limited: permission == PermissionState.limited,
        processed: 0,
        total: 0,
        errorMessage: null,
      );

      await _indexer.indexDeviceGallery(
        onProgress: (processed, total) {
          if (!mounted) return;
          state = state.copyWith(processed: processed, total: total);
        },
        shouldContinue: () => mounted && !_cancelled,
      );

      if (!mounted) return;
      state = state.copyWith(status: GalleryStatus.ready);
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        status: GalleryStatus.error,
        errorMessage: error.toString(),
      );
    } finally {
      _running = false;
    }
  }

  /// Reads permission status *without* prompting to distinguish a re-askable
  /// denial from a permanent one. photo_manager already showed the dialog; we
  /// only inspect the resulting OS state here.
  Future<bool> _isPermanentlyDenied() async {
    final statuses = await Future.wait([
      ph.Permission.photos.status,
      ph.Permission.videos.status,
      ph.Permission.storage.status,
    ]);
    return statuses.any((status) => status.isPermanentlyDenied);
  }
}
