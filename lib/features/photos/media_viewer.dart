import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
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
/// between assets, videos play inline.
class MediaViewer extends StatefulWidget {
  const MediaViewer({
    super.key,
    required this.assets,
    required this.initialIndex,
  });

  final List<GalleryAsset> assets;
  final int initialIndex;

  @override
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  late final PageController _pageController;
  late int _index;
  bool _chromeVisible = true;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleChrome() => setState(() => _chromeVisible = !_chromeVisible);

  @override
  Widget build(BuildContext context) {
    final asset = widget.assets[_index];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: _pageController,
              itemCount: widget.assets.length,
              onPageChanged: (i) => setState(() => _index = i),
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              builder: (context, index) {
                final item = widget.assets[index];
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
            _TopBar(
              visible: _chromeVisible,
              title: asset.fileName,
              subtitle: '${_index + 1} of ${widget.assets.length}',
              onClose: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    );
  }
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
