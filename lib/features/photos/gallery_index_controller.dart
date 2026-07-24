import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:photo_manager/photo_manager.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../repositories/gallery_repository.dart';
import '../../services/media_indexer_service.dart';

/// How much the Photos screen's own header has scrolled away (0 = fully
/// shown, 1 = fully collapsed) and whether multi-select is active. HomeShell
/// reads this to keep the floating avatar button moving and fading in
/// lockstep with that header, and to hide it entirely during selection —
/// it lives outside PhotosScreen because the avatar button is owned by
/// HomeShell (it's shared chrome across every tab), not by PhotosScreen.
class PhotosChromeState {
  const PhotosChromeState({this.collapse = 0, this.selectionMode = false});

  final double collapse;
  final bool selectionMode;
}

final photosChromeStateProvider =
    StateProvider<PhotosChromeState>((ref) => const PhotosChromeState());

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

/// Live stream of soft-deleted photos, for the Trash tab.
final trashStreamProvider =
    StreamProvider.autoDispose<List<GalleryAsset>>((ref) {
  return ref.watch(galleryRepositoryProvider).watchTrash();
});

final galleryIndexControllerProvider =
    StateNotifierProvider<GalleryIndexController, GalleryIndexState>((ref) {
  return GalleryIndexController(
    ref.watch(mediaIndexerProvider),
    ref.watch(galleryRepositoryProvider),
  );
});

/// Owns the whole permission → index → progress → error → retry flow. The UI
/// never touches the indexer directly; it only observes [GalleryIndexState]
/// and calls the intent methods below.
class GalleryIndexController extends StateNotifier<GalleryIndexState> {
  GalleryIndexController(this._indexer, this._repository)
      : super(const GalleryIndexState());

  final MediaIndexerService _indexer;
  final GalleryRepository _repository;

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

      // Enforce the 20-day trash retention we advertise to the user — items
      // past it are actually gone, not just hidden, so this genuinely
      // deletes the device files too. Runs opportunistically on each launch
      // rather than needing a background service, same as most gallery apps.
      unawaited(_purgeExpiredTrash());
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

  Future<void> _purgeExpiredTrash() async {
    try {
      final expired = await _repository.loadExpiredTrash();
      if (expired.isEmpty) return;
      final deletedPlatformIds = await _indexer.deleteFromDevice(
        expired.map((a) => a.platformId).toList(),
      );
      final deletedIds = expired
          .where((a) => deletedPlatformIds.contains(a.platformId))
          .map((a) => a.id)
          .toList();
      await _repository.permanentlyDeleteRows(deletedIds);
    } catch (_) {
      // Best-effort background cleanup — a failure here shouldn't affect
      // the gallery the user is actively looking at.
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
