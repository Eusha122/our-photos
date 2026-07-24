import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart' show Album;
import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../models/timeline_bucket.dart' as domain;
import '../../widgets/confirm_dialog.dart';
import '../../widgets/skeuomorphic.dart';
import 'asset_group_screen.dart';
import 'asset_thumbnail.dart';
import 'asset_tile.dart';
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
/// Fine for photo tiles — nothing critical sits at their very bottom edge.
const double _dockOverlap = 24;

/// Bottom clearance for Timeline/Albums, where — unlike photo tiles — every
/// row's actual content (a title, an album name) is anchored at its bottom
/// edge. This fully clears the dock's ~92px footprint (74 tall + 18 margin)
/// plus a little breathing room, so the last row always scrolls fully clear
/// of it instead of staying permanently unreadable underneath.
const double _dockClearance = 112;

class _PhotosScreenState extends ConsumerState<PhotosScreen>
    with TickerProviderStateMixin {
  int _segment = 0;
  double _tileSize = 112;
  final Set<String> _selectedIds = {};
  final Set<String> _removingIds = {};

  // A one-shot dim "pulse" over the whole grid — rises then falls back out —
  // that plays once, at the exact moment a long-press lifts a photo into
  // selection mode. Together with the haptic tap and the tile's own
  // pop-scale, this is the iOS long-press-to-select feel: a tactile jolt,
  // the background recedes, then it's handed back to you to keep selecting.
  //
  // This is a flat alpha dim, not a real-time Gaussian blur. A live
  // BackdropFilter has to re-sample and re-blur everything behind it on
  // every single animation frame — expensive over a whole grid of photos —
  // and doing that concurrently with the tile's pop-scale is exactly what
  // reads as jank/lag. A cheap dim keeps the "background recedes" feeling
  // genuinely smooth, which is the actual goal.
  late final AnimationController _selectPulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );
  late final Animation<double> _selectPulse = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 0.0)
          .chain(CurveTween(curve: Curves.easeInCubic)),
      weight: 70,
    ),
  ]).animate(_selectPulseController);

  bool get _selectionMode => _selectedIds.isNotEmpty;

  void _enterSelection(String assetId) {
    HapticFeedback.mediumImpact();
    _selectPulseController.forward(from: 0);
    setState(() => _selectedIds.add(assetId));
  }

  void _toggleSelect(String assetId) {
    HapticFeedback.selectionClick();
    setState(() {
      if (!_selectedIds.remove(assetId)) _selectedIds.add(assetId);
    });
  }

  void _clearSelection() => setState(_selectedIds.clear);

  Future<void> _deleteSelected() async {
    final count = _selectedIds.length;
    final confirmed = await SkeuConfirmDialog.show(
      context,
      icon: Icons.delete_outline_rounded,
      title: 'Move to Trash?',
      message: count == 1
          ? 'This item will be moved to the Trash. Items in the Trash are '
              'automatically deleted forever after 20 days.'
          : 'These $count items will be moved to the Trash. Items in the '
              'Trash are automatically deleted forever after 20 days.',
      confirmLabel: 'Move to Trash',
    );
    if (confirmed != true) return;

    final ids = _selectedIds.toList();
    // Let the tiles visibly shrink away before the stream-driven grid
    // actually reflows around their absence — an instant list splice reads
    // as an abrupt jump cut, this reads as something being physically
    // lifted out.
    setState(() {
      _removingIds.addAll(ids);
      _selectedIds.clear();
    });
    await Future<void>.delayed(const Duration(milliseconds: 220));
    await ref.read(galleryRepositoryProvider).moveMultipleToRecycleBin(ids);
    if (!mounted) return;
    setState(() => _removingIds.removeAll(ids));
  }

  // 0 = header fully shown, 1 = fully collapsed. During a scroll this tracks
  // the raw delta 1:1 (jumps, no animation) so the header follows the finger
  // exactly like a native floating nav bar — a fixed-duration animation
  // triggered by a direction threshold is what read as "buggy": it snaps
  // fully open/closed regardless of how far you actually scrolled, and can
  // fight with the gesture. Only on release does it *animate* to the nearer
  // edge, which is the one place a native bar actually animates.
  late final AnimationController _collapse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  bool _handleScroll(ScrollNotification notification) {
    final headerHeight =
        MediaQuery.paddingOf(context).top + _headerContentHeight;
    if (headerHeight <= 0) return false;

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta;
      if (delta == null || delta == 0) return false;
      _collapse.value = (_collapse.value + delta / headerHeight).clamp(0, 1);
    } else if (notification is ScrollEndNotification) {
      final target = _collapse.value > 0.5 ? 1.0 : 0.0;
      if (_collapse.value != target) {
        _collapse.animateTo(
          target,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
        );
      }
    }
    return false;
  }

  @override
  void dispose() {
    _collapse.dispose();
    _selectPulseController.dispose();
    super.dispose();
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
                    selectedIds: _selectedIds,
                    removingIds: _removingIds,
                    selectionMode: _selectionMode,
                    onEnterSelection: _enterSelection,
                    onToggleSelect: _toggleSelect,
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
          // The long-press dim pulse — see _selectPulse above. Ignored for
          // hit-testing throughout, since the tap that triggered it has
          // already been consumed by the tile. A RepaintBoundary isolates
          // this from the grid so neither forces the other to repaint.
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _selectPulse,
                  builder: (context, child) {
                    final t = _selectPulse.value;
                    if (t <= 0.001) return const SizedBox.shrink();
                    return ColoredBox(
                      color: Colors.black.withValues(alpha: 0.32 * t),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topPadding,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween(begin: 0.94, end: 1.0).animate(animation),
                  child: child,
                ),
              ),
              child: _selectionMode
                  ? _SelectionBar(
                      key: const ValueKey('selection-bar'),
                      count: _selectedIds.length,
                      onCancel: _clearSelection,
                      onDelete: _deleteSelected,
                    )
                  : AnimatedBuilder(
                      key: const ValueKey('collapsing-header'),
                      animation: _collapse,
                      // `child` is the fully static content — a dark scrim (so the
                      // title/segmented control stay legible over colorful photos,
                      // no blur, matching the skeuomorphic material language rather
                      // than glassmorphism) plus the header itself. Wrapping it in
                      // RepaintBoundary lets the engine cache it as one layer and
                      // just re-*position* that layer every scroll frame instead of
                      // re-rastering the gradient/text/segmented-control each tick.
                      child: RepaintBoundary(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      SkeuPalette.backgroundBottom
                                          .withValues(alpha: 0.96),
                                      SkeuPalette.backgroundBottom
                                          .withValues(alpha: 0.86),
                                      SkeuPalette.backgroundBottom
                                          .withValues(alpha: 0),
                                    ],
                                    stops: const [0, 0.62, 1],
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              bottom: false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 18, 16, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 4, bottom: 16),
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
                                      labels: const [
                                        'Photos',
                                        'Timeline',
                                        'Albums'
                                      ],
                                      selected: _segment,
                                      onSelected: (value) => setState(() {
                                        _segment = value;
                                        _collapse.animateTo(
                                          0,
                                          duration:
                                              const Duration(milliseconds: 180),
                                          curve: Curves.easeOutCubic,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      builder: (context, child) => IgnorePointer(
                        ignoring: _collapse.value > 0.5,
                        child: Transform.translate(
                          offset: Offset(0, -topPadding * _collapse.value),
                          child: child,
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

/// Replaces the collapsing title/segmented-control header while one or more
/// photos are selected — always fully visible (no scroll-collapse) so the
/// delete action is never accidentally scrolled out of reach.
class _SelectionBar extends StatelessWidget {
  const _SelectionBar({
    super.key,
    required this.count,
    required this.onCancel,
    required this.onDelete,
  });

  final int count;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: SkeuSurface(
            material: SkeuMaterial.graphite,
            radius: 18,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SkeuIconButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Cancel',
                  size: 40,
                  onTap: onCancel,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$count selected',
                    style: const TextStyle(
                      color: SkeuPalette.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                SkeuIconButton(
                  icon: Icons.delete_outline_rounded,
                  tooltip: 'Move to Trash',
                  size: 40,
                  onTap: onDelete,
                ),
              ],
            ),
          ),
        ),
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
    required this.selectedIds,
    required this.removingIds,
    required this.selectionMode,
    required this.onEnterSelection,
    required this.onToggleSelect,
  });

  final double tileSize;
  final double topPadding;
  final ValueChanged<double> onScale;
  final Set<String> selectedIds;
  final Set<String> removingIds;
  final bool selectionMode;
  final ValueChanged<String> onEnterSelection;
  final ValueChanged<String> onToggleSelect;

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
            itemBuilder: (context, index) {
              final asset = assets[index];
              final selected = selectedIds.contains(asset.id);
              final removing = removingIds.contains(asset.id);
              return GestureDetector(
                onLongPress:
                    selectionMode ? null : () => onEnterSelection(asset.id),
                child: AnimatedScale(
                  // A held tile "pops" slightly larger with a springy
                  // overshoot as it lifts into selection — the visual half
                  // of the same moment as the haptic tap and the blur pulse.
                  scale: removing ? 0.55 : (selected ? 1.05 : 1),
                  duration: Duration(milliseconds: removing ? 220 : 260),
                  curve: removing ? Curves.easeInCubic : Curves.easeOutBack,
                  child: AnimatedOpacity(
                    opacity: removing ? 0 : 1,
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInCubic,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AssetTile(
                          asset: asset,
                          onOpen: selectionMode
                              ? () => onToggleSelect(asset.id)
                              : () => Navigator.of(context).push(
                                    mediaViewerRoute(
                                      assets: assets,
                                      initialIndex: index,
                                    ),
                                  ),
                        ),
                        IgnorePointer(
                          child: AnimatedOpacity(
                            opacity: selected ? 1 : 0,
                            duration: const Duration(milliseconds: 160),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: SkeuPalette.titanium,
                                  width: 3,
                                ),
                                color: Colors.black.withValues(alpha: 0.18),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 7,
                          left: 7,
                          child: AnimatedScale(
                            scale: selectionMode ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutBack,
                            child: AnimatedOpacity(
                              opacity: selectionMode ? 1 : 0,
                              duration: const Duration(milliseconds: 140),
                              child: SizedBox.square(
                                dimension: 24,
                                child: SkeuContainer(
                                  material: selected
                                      ? SkeuMaterial.aluminum
                                      : SkeuMaterial.graphite,
                                  radius: 12,
                                  lift: 0.5,
                                  texture: false,
                                  child: AnimatedScale(
                                    scale: selected ? 1 : 0,
                                    duration: const Duration(milliseconds: 160),
                                    curve: Curves.easeOutBack,
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 15,
                                      color: Color(0xFF111111),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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

class _TimelineList extends StatelessWidget {
  const _TimelineList({
    required this.buckets,
    required this.topPadding,
  });

  final List<domain.TimelineBucket> buckets;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    if (buckets.isEmpty) {
      return _SectionEmpty(
        icon: Icons.schedule_rounded,
        message: 'Your timeline appears once your photos are indexed.',
        topPadding: topPadding,
      );
    }
    return ListView.separated(
      key: const ValueKey('timeline'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, topPadding, 16, _dockClearance),
      itemBuilder: (context, index) {
        final bucket = buckets[index];
        return _GroupRow(
          title: bucket.title,
          subtitle: '${bucket.assets.length} '
              '${bucket.assets.length == 1 ? 'item' : 'items'}',
          coverAssetId:
              bucket.assets.isEmpty ? null : bucket.assets.first.platformId,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => AssetGroupScreen(
                title: bucket.title,
                assets: bucket.assets,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: buckets.length,
    );
  }
}

/// A tappable leather row with a real cover thumbnail — used by both the
/// Timeline list and (in a 2-column grid) the Albums list, so a group with
/// no photos behind it can no longer look identical to one that does.
class _GroupRow extends StatelessWidget {
  const _GroupRow({
    required this.title,
    required this.subtitle,
    required this.coverAssetId,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String? coverAssetId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: SkeuSurface(
        material: SkeuMaterial.leather,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 60,
                height: 60,
                child: coverAssetId == null
                    ? const ColoredBox(color: SkeuPalette.graphiteDeep)
                    : Image(
                        image: AssetThumbnailProvider(coverAssetId!),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        errorBuilder: (context, error, stack) =>
                            const ColoredBox(color: SkeuPalette.graphiteDeep),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: SkeuPalette.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: SkeuPalette.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: SkeuPalette.muted),
          ],
        ),
      ),
    );
  }
}

class _AlbumList extends StatelessWidget {
  const _AlbumList({
    required this.albums,
    required this.topPadding,
  });

  final List<Album> albums;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return _SectionEmpty(
        icon: Icons.photo_album_outlined,
        message: 'Albums appear here once your device folders are indexed.',
        topPadding: topPadding,
      );
    }
    return GridView.builder(
      key: const ValueKey('albums'),
      padding: EdgeInsets.fromLTRB(16, topPadding, 16, _dockClearance),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) => _AlbumCard(album: albums[index]),
    );
  }
}

/// An album card with its real cover photo (the album's most recent asset)
/// and item count, fetched from the [AlbumAssets] join. Tapping opens every
/// photo actually inside that album.
class _AlbumCard extends ConsumerWidget {
  const _AlbumCard({required this.album});

  final Album album;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<GalleryAsset>>(
      future: ref.watch(galleryRepositoryProvider).loadAlbumAssets(album.id),
      builder: (context, snapshot) {
        final assets = snapshot.data ?? const <GalleryAsset>[];
        return Pressable(
          onTap: assets.isEmpty
              ? () {}
              : () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => AssetGroupScreen(
                        title: album.title,
                        assets: assets,
                      ),
                    ),
                  ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: SkeuShadow.contact(),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: DecoratedBox(
                decoration:
                    const BoxDecoration(color: SkeuPalette.graphiteDeep),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (assets.isNotEmpty)
                      Image(
                        image: AssetThumbnailProvider(assets.first.platformId),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        errorBuilder: (context, error, stack) =>
                            const SizedBox.shrink(),
                      ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.78),
                          ],
                          stops: const [0.4, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            album.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            assets.isEmpty
                                ? 'Empty'
                                : '${assets.length} '
                                    '${assets.length == 1 ? 'item' : 'items'}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.78),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Compact centered empty state for the Timeline / Albums segments.
class _SectionEmpty extends StatelessWidget {
  const _SectionEmpty({
    required this.icon,
    required this.message,
    required this.topPadding,
  });

  final IconData icon;
  final String message;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: _dockOverlap),
      child: Center(
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
      ),
    );
  }
}
