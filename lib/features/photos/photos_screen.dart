import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
import '../../widgets/liquid_glass.dart';
import '../../widgets/status_badges.dart';
import 'asset_thumbnail.dart';
import 'gallery_index_controller.dart';
import 'media_viewer.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  int _segment = 0;
  double _tileSize = 112;

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(galleryRepositoryProvider);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, top: 2, bottom: 16),
              child: Text(
                'Our Photos',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            _GlassSegmentedControl(
              labels: const ['Photos', 'Timeline', 'Albums'],
              selected: _segment,
              onChanged: (value) => setState(() => _segment = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: switch (_segment) {
                  0 => _PhotosGrid(
                      tileSize: _tileSize,
                      onScale: (scale) => setState(
                        () => _tileSize = (_tileSize / scale).clamp(76, 176),
                      ),
                    ),
                  1 => FutureBuilder(
                      future: repository.loadTimeline(),
                      builder: (context, snapshot) => _TimelineList(
                        buckets: snapshot.data ?? const [],
                      ),
                    ),
                  _ => FutureBuilder(
                      future: repository.loadAlbums(),
                      builder: (context, snapshot) => _AlbumList(
                        albums: snapshot.data ?? const [],
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosGrid extends ConsumerWidget {
  const _PhotosGrid({required this.tileSize, required this.onScale});

  final double tileSize;
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
        onAction: () =>
            ref.read(galleryIndexControllerProvider.notifier).retry(),
      ),
      loading: () => _GalleryStatusView.forIndex(index, ref),
      data: (assets) {
        if (assets.isEmpty) return _GalleryStatusView.forIndex(index, ref);
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
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
    this.progress,
    this.showSpinner = false,
  });

  /// Builds the right state widget from the controller's [GalleryIndexState].
  factory _GalleryStatusView.forIndex(GalleryIndexState index, WidgetRef ref) {
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
        );
      case GalleryStatus.error:
        return _GalleryStatusView(
          icon: Icons.error_outline_rounded,
          title: "Couldn't scan your library",
          message: index.errorMessage ?? 'An unexpected error occurred.',
          actionLabel: 'Retry',
          onAction: controller.retry,
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
        );
      case GalleryStatus.ready:
        return _GalleryStatusView(
          icon: Icons.photo_library_outlined,
          title: 'No photos found',
          message: 'We didn’t find any photos or videos on this device yet.',
          actionLabel: 'Refresh Library',
          onAction: controller.retry,
        );
      case GalleryStatus.initial:
        return const _GalleryStatusView(
          icon: Icons.photo_library_outlined,
          title: 'Preparing…',
          message: 'Getting your gallery ready.',
          showSpinner: true,
        );
    }
  }

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final double? progress;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44, color: theme.colorScheme.primary),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                  ),
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
            if (secondaryLabel != null && onSecondary != null) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: onSecondary,
                child: Text(secondaryLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A glassy iOS-style segmented control with a spring-eased sliding thumb.
class _GlassSegmentedControl extends StatelessWidget {
  const _GlassSegmentedControl({
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return LiquidGlass(
      borderRadius: 22,
      blur: 18,
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        height: 42,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final segWidth = constraints.maxWidth / labels.length;
            return Stack(
              children: [
                AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 340),
                  curve: Curves.easeOutCubic,
                  start: selected * segWidth,
                  top: 0,
                  bottom: 0,
                  width: segWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: dark ? 0.18 : 0.92),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var i = 0; i < labels.length; i++)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onChanged(i),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 220),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: selected == i
                                    ? (dark
                                        ? Colors.white
                                        : const Color(0xFF171412))
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.55),
                              ),
                              child: Text(labels[i]),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t.clamp(0, 1),
        child: Transform.scale(scale: 0.94 + 0.06 * t, child: child),
      ),
      child: _Pressable(
        onTap: onOpen,
        child: Hero(
          tag: 'asset:${asset.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HSLColor.fromAHSL(1, hue.toDouble(), 0.45, 0.42).toColor(),
                    HSLColor.fromAHSL(
                      1,
                      ((hue + 45) % 360).toDouble(),
                      0.52,
                      0.62,
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
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          effective[index].toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        subtitle: const Text('Tap to see memories, places, and best shots'),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
      separatorBuilder: (_, __) => const Divider(height: 24),
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
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              effective[index].toString(),
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
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
