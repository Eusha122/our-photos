import 'package:flutter/material.dart';

import '../../models/gallery_asset.dart';
import '../../models/media_status.dart';
import '../../widgets/skeuomorphic.dart';
import '../../widgets/status_badges.dart';
import 'asset_thumbnail.dart';

/// A single photo/video tile: real device thumbnail, a hero tag for the
/// full-screen viewer transition, a play glyph for videos, and status
/// badges. Shared by the Photos grid and [AssetGroupScreen] (album /
/// timeline / memory detail views) so they all look and behave identically.
class AssetTile extends StatelessWidget {
  const AssetTile({super.key, required this.asset, required this.onOpen});

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
    return Pressable(
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
class Pressable extends StatefulWidget {
  const Pressable({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
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
