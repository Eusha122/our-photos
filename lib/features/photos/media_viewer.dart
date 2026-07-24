import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/skeuomorphic.dart';
import 'asset_thumbnail.dart';

/// Opens the full-screen, swipeable gallery viewer with a fade + hero
/// transition over a black backdrop — like the system gallery.
Route<void> mediaViewerRoute({
  required List<GalleryAsset> assets,
  required int initialIndex,
}) {
  return PageRouteBuilder<void>(
    opaque: true,
    barrierColor: Colors.black,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (_, __, ___) =>
        MediaViewer(assets: assets, initialIndex: initialIndex),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: child,
    ),
  );
}

/// A real gallery viewer: pinch-zoom fills the whole screen, swipe pages
/// between assets, videos play inline, and a bottom bar exposes favorite /
/// share / info / trash — the standard set of actions on a single photo.
class MediaViewer extends ConsumerStatefulWidget {
  const MediaViewer({
    super.key,
    required this.assets,
    required this.initialIndex,
  });

  final List<GalleryAsset> assets;
  final int initialIndex;

  @override
  ConsumerState<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends ConsumerState<MediaViewer> {
  late final PageController _pageController;
  late List<GalleryAsset> _assets;
  late int _index;
  bool _chromeVisible = true;
  String? _fadingOutId;

  @override
  void initState() {
    super.initState();
    _assets = List.of(widget.assets);
    _index = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleChrome() => setState(() => _chromeVisible = !_chromeVisible);

  Future<void> _toggleFavorite(GalleryAsset asset) async {
    final next = !asset.isFavorite;
    setState(() {
      final i = _assets.indexWhere((a) => a.id == asset.id);
      if (i != -1) _assets[i] = _copyWithFavorite(asset, next);
    });
    await ref.read(galleryRepositoryProvider).toggleFavorite(asset.id, next);
  }

  Future<void> _share(GalleryAsset asset) async {
    try {
      final entity = await AssetEntity.fromId(asset.platformId);
      final file = await entity?.file;
      if (file == null) throw StateError('File is unavailable');
      await Share.shareXFiles([XFile(file.path)]);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Couldn't share this item.")),
      );
    }
  }

  Future<void> _moveToTrash(GalleryAsset asset) async {
    final confirmed = await SkeuConfirmDialog.show(
      context,
      icon: Icons.delete_outline_rounded,
      title: 'Move to Trash?',
      message: 'This item will be moved to the Trash. Items in the Trash '
          'are automatically deleted forever after 20 days.',
      confirmLabel: 'Move to Trash',
    );
    if (confirmed != true) return;

    final removedIndex = _assets.indexWhere((a) => a.id == asset.id);
    if (removedIndex == -1) return;

    // Fade the current page out before it actually leaves the list, rather
    // than snapping straight to the next photo.
    setState(() => _fadingOutId = asset.id);
    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (!mounted) return;

    await ref.read(galleryRepositoryProvider).moveToRecycleBin(asset.id);
    if (!mounted) return;
    setState(() {
      _assets.removeAt(removedIndex);
      _fadingOutId = null;
    });
    if (_assets.isEmpty) {
      Navigator.of(context).maybePop();
      return;
    }
    final nextIndex = removedIndex.clamp(0, _assets.length - 1);
    setState(() => _index = nextIndex);
    _pageController.jumpToPage(nextIndex);
  }

  void _showInfo(GalleryAsset asset) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _InfoSheet(asset: asset),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_assets.isEmpty) return const SizedBox.shrink();
    final asset = _assets[_index];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: _pageController,
              itemCount: _assets.length,
              onPageChanged: (i) => setState(() => _index = i),
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              builder: (context, index) {
                final item = _assets[index];
                final tag = 'asset:${item.id}';
                if (item.kind == MediaKind.video) {
                  return PhotoViewGalleryPageOptions.customChild(
                    heroAttributes: PhotoViewHeroAttributes(tag: tag),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 2,
                    child: _VideoPage(
                      asset: item,
                      onTap: _toggleChrome,
                    ),
                  );
                }
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      AssetThumbnailProvider(item.platformId, pixelSize: 2048),
                  heroAttributes: PhotoViewHeroAttributes(tag: tag),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  initialScale: PhotoViewComputedScale.contained,
                  onTapUp: (_, __, ___) => _toggleChrome(),
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.broken_image_rounded,
                        color: Colors.white38, size: 48),
                  ),
                );
              },
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
            IgnorePointer(
              child: AnimatedOpacity(
                opacity: _fadingOutId == asset.id ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeIn,
                child: const ColoredBox(color: Colors.black),
              ),
            ),
            _TopBar(
              visible: _chromeVisible,
              title: asset.fileName,
              subtitle: '${_index + 1} of ${_assets.length}',
              onClose: () => Navigator.of(context).maybePop(),
            ),
            _BottomActionsBar(
              visible: _chromeVisible,
              asset: asset,
              onFavorite: () => _toggleFavorite(asset),
              onShare: () => _share(asset),
              onInfo: () => _showInfo(asset),
              onTrash: () => _moveToTrash(asset),
            ),
          ],
        ),
      ),
    );
  }
}

GalleryAsset _copyWithFavorite(GalleryAsset asset, bool isFavorite) {
  return GalleryAsset(
    id: asset.id,
    platformId: asset.platformId,
    fileName: asset.fileName,
    kind: asset.kind,
    createdAt: asset.createdAt,
    addedAt: asset.addedAt,
    width: asset.width,
    height: asset.height,
    sizeBytes: asset.sizeBytes,
    folderName: asset.folderName,
    cameraMake: asset.cameraMake,
    cameraModel: asset.cameraModel,
    latitude: asset.latitude,
    longitude: asset.longitude,
    placeName: asset.placeName,
    isFavorite: isFavorite,
    isHidden: asset.isHidden,
    isDeleted: asset.isDeleted,
    statuses: asset.statuses,
  );
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.visible,
    required this.title,
    required this.subtitle,
    required this.onClose,
  });

  final bool visible;
  final String title;
  final String subtitle;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: IgnorePointer(
        ignoring: !visible,
        child: Padding(
          padding: EdgeInsets.only(top: top + 10, left: 14, right: 14),
          child: Align(
            alignment: Alignment.topCenter,
            child: SkeuContainer(
              material: SkeuMaterial.graphite,
              radius: 24,
              lift: 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    SkeuIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: onClose,
                      size: 38,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: SkeuPalette.ink,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              shadows: [
                                Shadow(
                                  color: Color(0xCC000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                          ),
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
                    const SizedBox(width: 6),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Favorite / Share / Info / Trash — the standard single-photo action set,
/// docked at the bottom like the system gallery's.
class _BottomActionsBar extends StatelessWidget {
  const _BottomActionsBar({
    required this.visible,
    required this.asset,
    required this.onFavorite,
    required this.onShare,
    required this.onInfo,
    required this.onTrash,
  });

  final bool visible;
  final GalleryAsset asset;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onInfo;
  final VoidCallback onTrash;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: IgnorePointer(
          ignoring: !visible,
          child: Padding(
            padding: EdgeInsets.only(left: 14, right: 14, bottom: bottom + 14),
            child: SkeuContainer(
              material: SkeuMaterial.graphite,
              radius: 24,
              lift: 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: asset.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      label: asset.isFavorite ? 'Favorited' : 'Favorite',
                      selected: asset.isFavorite,
                      onTap: onFavorite,
                    ),
                    _ActionButton(
                      icon: Icons.ios_share_rounded,
                      label: 'Share',
                      onTap: onShare,
                    ),
                    _ActionButton(
                      icon: Icons.info_outline_rounded,
                      label: 'Info',
                      onTap: onInfo,
                    ),
                    _ActionButton(
                      icon: Icons.delete_outline_rounded,
                      label: 'Trash',
                      onTap: onTrash,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SkeuPressAnimation(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? const Color(0xFFE8505B) : SkeuPalette.ink,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: SkeuPalette.muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

/// The "About" panel — real metadata, fetching live file size (the indexer
/// doesn't currently record it) rather than showing a stale/fake number.
class _InfoSheet extends StatelessWidget {
  const _InfoSheet({required this.asset});

  final GalleryAsset asset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SkeuSurface(
          material: SkeuMaterial.graphite,
          radius: 22,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: SkeuPalette.muted.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                asset.fileName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: SkeuPalette.ink,
                ),
              ),
              const SizedBox(height: 14),
              _InfoRow(
                icon: Icons.straighten_rounded,
                label: 'Dimensions',
                value: '${asset.width} × ${asset.height}',
              ),
              _InfoRow(
                icon: asset.kind == MediaKind.video
                    ? Icons.videocam_outlined
                    : Icons.image_outlined,
                label: 'Type',
                value: asset.kind.name[0].toUpperCase() +
                    asset.kind.name.substring(1),
              ),
              _InfoRow(
                icon: Icons.event_outlined,
                label: 'Date taken',
                value: _formatDate(asset.createdAt),
              ),
              if ((asset.cameraMake ?? asset.cameraModel) != null)
                _InfoRow(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  value: [asset.cameraMake, asset.cameraModel]
                      .whereType<String>()
                      .join(' '),
                ),
              if (asset.placeName != null)
                _InfoRow(
                  icon: Icons.place_outlined,
                  label: 'Place',
                  value: asset.placeName!,
                ),
              FutureBuilder<String>(
                future: _fileSizeLabel(asset.platformId),
                builder: (context, snapshot) => _InfoRow(
                  icon: Icons.sd_storage_outlined,
                  label: 'File size',
                  value: snapshot.data ?? 'Calculating…',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String> _fileSizeLabel(String platformId) async {
    try {
      final entity = await AssetEntity.fromId(platformId);
      final file = await entity?.file;
      if (file == null) return 'Unknown';
      final bytes = await file.length();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) {
        return '${(bytes / 1024).toStringAsFixed(1)} KB';
      }
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } catch (_) {
      return 'Unknown';
    }
  }

  static String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} · '
        '$hour12:$minute $period';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 19, color: SkeuPalette.titanium),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: SkeuPalette.muted, fontSize: 13),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: SkeuPalette.ink,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Inline video page: shows the frame as a poster while the player warms up,
/// then plays. Tap toggles play/pause; a glass scrubber sits at the bottom.
class _VideoPage extends StatefulWidget {
  const _VideoPage({required this.asset, required this.onTap});

  final GalleryAsset asset;
  final VoidCallback onTap;

  @override
  State<_VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<_VideoPage> {
  VideoPlayerController? _controller;
  bool _loading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final entity = await AssetEntity.fromId(widget.asset.platformId);
      final File? file = await entity?.file;
      if (file == null) {
        throw StateError('Video file is unavailable');
      }
      final controller = VideoPlayerController.file(file);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    final controller = _controller;
    if (controller == null) return;
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (_error != null) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_off_rounded, color: Colors.white38, size: 48),
            SizedBox(height: 12),
            Text('This video could not be played',
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }

    if (_loading || controller == null) {
      // Poster (the still frame) + spinner, so the transition feels seamless.
      return Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetThumbnailProvider(widget.asset.platformId,
                pixelSize: 1024),
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: _togglePlayback,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio == 0
                  ? 1
                  : controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          // Center play/pause affordance — a raised aluminum dial, like a
          // camera shutter button, with an engraved play glyph.
          ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: controller,
            builder: (context, value, _) => AnimatedOpacity(
              opacity: value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: const Center(
                child: SizedBox.square(
                  dimension: 72,
                  child: SkeuContainer(
                    material: SkeuMaterial.aluminum,
                    radius: 36,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Color(0xFF111111),
                      size: 38,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Scrubber — an inset aluminum control strip.
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.paddingOf(context).bottom + 20,
            child: SkeuSurface(
              material: SkeuMaterial.graphite,
              radius: 18,
              lift: 0.7,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                padding: EdgeInsets.zero,
                colors: const VideoProgressColors(
                  playedColor: SkeuPalette.titanium,
                  bufferedColor: SkeuPalette.aluminumDark,
                  backgroundColor: Color(0x33000000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
