import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
import '../../widgets/skeuomorphic.dart';
import '../../widgets/status_badges.dart';
import 'asset_thumbnail.dart';
import 'gallery_index_controller.dart';
import 'media_viewer.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

/// Height of the header content (title + gap + segmented control) below the
/// safe-area inset — used so scrollable content knows how much top padding
/// to reserve, and so the header knows how far to slide away when hidden.
const double _headerContentHeight = 140;

/// How much of the dock's own footprint (74 tall + 18 bottom margin) the
/// content is allowed to scroll *under*. Deliberately small: the dock should
/// float directly over the last row of photos, not sit above a bare gutter.
const double _dockOverlap = 24;

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  int _segment = 0;
  double _tileSize = 112;
  bool _headerVisible = true;

  // The segmented control lives in the collapsing header (not the bottom
  // dock, which always stays put) — scrolling down tucks it away for more
  // viewing room; scrolling up, or reaching the top, brings it back.
  bool _handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta;
      if (delta == null || delta.abs() < 3) return false;
      final shouldShow = delta < 0;
      if (shouldShow != _headerVisible) {
        setState(() => _headerVisible = shouldShow);
      }
    } else if (notification is ScrollEndNotification) {
      final metrics = notification.metrics;
      if (metrics.pixels <= metrics.minScrollExtent && !_headerVisible) {
        setState(() => _headerVisible = true);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(galleryRepositoryProvider);
    final topPadding = MediaQuery.paddingOf(context).top + _headerContentHeight;

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: Stack(
        children: [
          // Full-bleed content: its own top/bottom padding reserves room for
          // the header and dock, but that padding scrolls away with the rest
          // of the content — so photos genuinely pass behind both, rather
          // than stopping short in a dead gutter.
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: switch (_segment) {
                0 => _PhotosGrid(
                    key: const ValueKey('grid'),
                    tileSize: _tileSize,
                    topPadding: topPadding,
                    onScale: (scale) => setState(
                      () => _tileSize = (_tileSize / scale).clamp(76, 176),
                    ),
                  ),
                1 => FutureBuilder(
                    key: const ValueKey('timeline'),
                    future: repository.loadTimeline(),
                    builder: (context, snapshot) => _TimelineList(
                      buckets: snapshot.data ?? const [],
                      topPadding: topPadding,
                    ),
                  ),
                _ => FutureBuilder(
                    key: const ValueKey('albums'),
                    future: repository.loadAlbums(),
                    builder: (context, snapshot) => _AlbumList(
                      albums: snapshot.data ?? const [],
                      topPadding: topPadding,
                    ),
                  ),
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              offset: _headerVisible ? Offset.zero : const Offset(0, -1.2),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _headerVisible ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !_headerVisible,
                  child: RepaintBoundary(
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 16),
                              child: Text(
                                'Our Photos',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            SkeuSegmentedControl(
                              labels: const ['Photos', 'Timeline', 'Albums'],
                              selected: _segment,
                              onSelected: (value) => setState(() {
                                _segment = value;
                                _headerVisible = true;
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotosGrid extends ConsumerWidget {
  const _PhotosGrid({
    super.key,
    required this.tileSize,
    required this.topPadding,
    required this.onScale,
  });

  final double tileSize;
  final double topPadding;
  final ValueChanged<double> onScale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photosStreamProvider);
    final index = ref.watch(galleryIndexControllerProvider);

    return photos.when(
      // A DB error surfaces as an honest error state rather than fake data.
      error: (_, __) => _GalleryStatusView(
        icon: Icons.error_outline_rounded,
        title: 'Could not read your library',
        message: 'Something went wrong while loading your photos.',
        actionLabel: 'Retry',
        topPadding: topPadding,
        onAction: () =>
            ref.read(galleryIndexControllerProvider.notifier).retry(),
      ),
      loading: () => _GalleryStatusView.forIndex(index, ref, topPadding),
      data: (assets) {
        if (assets.isEmpty) {
          return _GalleryStatusView.forIndex(index, ref, topPadding);
        }
        return _buildGrid(assets);
      },
    );
  }

  Widget _buildGrid(List<GalleryAsset> assets) {
    return GestureDetector(
      onScaleUpdate: (details) {
        if ((details.scale - 1).abs() > 0.03) onScale(details.scale);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On Android the engine draws a warm-up frame before the surface has
          // been measured, so the whole tree is laid out at 0x0 (see the
          // "FlutterRenderer: Width is zero" log). SliverGridDelegateWithMax-
          // CrossAxisExtent hard-asserts crossAxisExtent > 0, so building the
          // grid at zero width throws inside flushLayout and wedges the
          // pipeline. Wait for a real width before creating the grid.
          if (!constraints.maxWidth.isFinite || constraints.maxWidth <= 0) {
            return const SizedBox.shrink();
          }
          return GridView.builder(
            key: const ValueKey('photos-grid'),
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16, topPadding, 16, _dockOverlap),
            // Pre-builds/decodes items further outside the viewport so fast
            // flings don't reveal blank tiles — smoother perceived scroll.
            // ignore: deprecated_member_use
            cacheExtent: 900,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: tileSize,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: assets.length,
            itemBuilder: (context, index) => _AssetTile(
              asset: assets[index],
              onOpen: () => Navigator.of(context).push(
                mediaViewerRoute(assets: assets, initialIndex: index),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Full-bleed placeholder shown when there are no photos to display yet:
/// scanning progress, permission prompts, empty library, or errors.
class _GalleryStatusView extends StatelessWidget {
  const _GalleryStatusView({
    required this.icon,
    required this.title,
    required this.message,
    required this.topPadding,
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
    this.progress,
    this.showSpinner = false,
  });

  /// Builds the right state widget from the controller's [GalleryIndexState].
  factory _GalleryStatusView.forIndex(
    GalleryIndexState index,
    WidgetRef ref,
    double topPadding,
  ) {
    final controller = ref.read(galleryIndexControllerProvider.notifier);
    switch (index.status) {
      case GalleryStatus.permissionDenied:
        return _GalleryStatusView(
          icon: Icons.lock_outline_rounded,
          title: 'Photo access needed',
          message: 'Our Photos needs access to your photos and videos to show '
              'your library.',
          actionLabel: 'Grant access',
          onAction: controller.retry,
          topPadding: topPadding,
        );
      case GalleryStatus.permissionPermanentlyDenied:
        return _GalleryStatusView(
          icon: Icons.lock_outline_rounded,
          title: 'Photo access is blocked',
          message:
              'Enable photo & video access for Our Photos in system settings '
              'to see your library.',
          actionLabel: 'Open settings',
          onAction: controller.openSettings,
          secondaryLabel: 'Try again',
          onSecondary: controller.retry,
          topPadding: topPadding,
        );
      case GalleryStatus.error:
        return _GalleryStatusView(
          icon: Icons.error_outline_rounded,
          title: "Couldn't scan your library",
          message: index.errorMessage ?? 'An unexpected error occurred.',
          actionLabel: 'Retry',
          onAction: controller.retry,
          topPadding: topPadding,
        );
      case GalleryStatus.checkingPermission:
      case GalleryStatus.scanning:
        final counter = index.total > 0
            ? 'Scanning your library… ${index.processed} of ${index.total}'
            : 'Scanning your library…';
        return _GalleryStatusView(
          icon: Icons.photo_library_outlined,
          title: 'Building your gallery',
          message: counter,
          progress: index.progress,
          showSpinner: true,
          actionLabel: 'Cancel',
          onAction: controller.cancel,
          topPadding: topPadding,
        );
      case GalleryStatus.ready:
        return _GalleryStatusView(
          icon: Icons.photo_library_outlined,
          title: 'No photos found',
          message: 'We didn’t find any photos or videos on this device yet.',
          actionLabel: 'Refresh Library',
          onAction: controller.retry,
          topPadding: topPadding,
        );
      case GalleryStatus.initial:
        return _GalleryStatusView(
          icon: Icons.photo_library_outlined,
          title: 'Preparing…',
          message: 'Getting your gallery ready.',
          showSpinner: true,
          topPadding: topPadding,
        );
    }
  }

  final IconData icon;
  final String title;
  final String message;
  final double topPadding;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final double? progress;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: _dockOverlap),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 96,
              child: SkeuContainer(
                material: SkeuMaterial.aluminum,
                radius: 48,
                child: Icon(icon, size: 44, color: const Color(0xFF121212)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            if (showSpinner) ...[
              const SizedBox(height: 22),
              SizedBox(
                width: 180,
                child: SkeuSurface(
                  material: SkeuMaterial.graphite,
                  radius: 8,
                  padding: const EdgeInsets.all(4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: (progress ?? 0.18).clamp(0.08, 1),
                      child: const SizedBox(
                        height: 7,
                        child: SkeuContainer(
                          material: SkeuMaterial.aluminum,
                          radius: 5,
                          child: SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              SkeuButton(label: actionLabel!, onTap: onAction),
            ],
            if (secondaryLabel != null && onSecondary != null) ...[
              const SizedBox(height: 8),
              SkeuButton(
                label: secondaryLabel!,
                onTap: onSecondary,
                compact: true,
              ),
            ],
          ],
        ),
      ),
      ),
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({required this.asset, required this.onOpen});

  final GalleryAsset asset;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final hue = asset.id.hashCode.remainder(360).abs();
    // No per-tile entrance animation: GridView.builder creates a fresh tile
    // widget every time one scrolls into view, so an AnimationController per
    // tile means dozens spin up during a fast fling — costly for smooth
    // scroll. The image's own load-fade (frameBuilder below) is enough, and
    // it's a no-op after the first decode thanks to the image cache.
    return _Pressable(
      onTap: onOpen,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: SkeuShadow.contact(),
        ),
        child: Hero(
          tag: 'asset:${asset.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    HSLColor.fromAHSL(1, hue.toDouble(), 0.2, 0.26).toColor(),
                    HSLColor.fromAHSL(
                      1,
                      ((hue + 45) % 360).toDouble(),
                      0.26,
                      0.46,
                    ).toColor(),
                  ],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: AssetThumbnailProvider(asset.platformId),
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                    errorBuilder: (context, error, stack) =>
                        const SizedBox.shrink(),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.center,
                        colors: [
                          Colors.white.withValues(alpha: 0.10),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  if (asset.kind == MediaKind.video)
                    const Center(
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  Positioned(
                    left: 7,
                    right: 7,
                    bottom: 7,
                    child: StatusBadges(statuses: asset.statuses),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Adds a subtle press-in scale for a tactile, premium feel.
class _Pressable extends StatefulWidget {
  const _Pressable({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) {
        setState(() => _down = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? 0.95 : 1,
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  const _TimelineList({required this.buckets});

  final List<dynamic> buckets;

  @override
  Widget build(BuildContext context) {
    if (buckets.isEmpty) {
      return const _SectionEmpty(
        icon: Icons.schedule_rounded,
        message: 'Your timeline appears once your photos are indexed.',
      );
    }
    final effective = buckets.map((bucket) => bucket.title).toList();
    return ListView.separated(
      key: const ValueKey('timeline'),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => SkeuPressAnimation(
        onTap: () {},
        child: SkeuSurface(
          material: SkeuMaterial.leather,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      effective[index].toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: SkeuPalette.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap to see memories, places, and best shots',
                      style: TextStyle(color: SkeuPalette.muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: SkeuPalette.muted),
            ],
          ),
        ),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: effective.length,
    );
  }
}

class _AlbumList extends StatelessWidget {
  const _AlbumList({required this.albums});

  final List<dynamic> albums;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return const _SectionEmpty(
        icon: Icons.photo_album_outlined,
        message: 'Albums appear here once your device folders are indexed.',
      );
    }
    final effective = albums.map((album) => album.title).toList();
    return GridView.builder(
      key: const ValueKey('albums'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: effective.length,
      itemBuilder: (context, index) => SkeuSurface(
        material: SkeuMaterial.leather,
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            effective[index].toString(),
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: SkeuPalette.ink,
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact centered empty state for the Timeline / Albums segments.
class _SectionEmpty extends StatelessWidget {
  const _SectionEmpty({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
