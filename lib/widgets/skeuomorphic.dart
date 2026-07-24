import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

enum SkeuMaterial {
  graphite,
  aluminum,
  leather,
  paper,
}

/// A deliberately monochrome, neutral-grey palette — no warm tones, no
/// saturated hues. Depth comes from lightness steps and shadow/bevel work,
/// not from color, which is what reads as "professional" rather than
/// "glossy consumer plastic."
class SkeuPalette {
  static const backgroundTop = Color(0xFF17181A);
  static const backgroundBottom = Color(0xFF0A0A0B);
  static const graphite = Color(0xFF232427);
  static const graphiteDeep = Color(0xFF131316);
  static const aluminum = Color(0xFF86888D);
  static const aluminumDark = Color(0xFF525459);
  static const titanium = Color(0xFFB9BBC0);
  static const leather = Color(0xFF2B2C30);
  static const leatherEdge = Color(0xFF37383D);
  static const paper = Color(0xFFAEB0B4);
  static const ink = Color(0xFFEDEEF0);
  static const muted = Color(0xFF9698A0);
}

class SkeuShadow {
  const SkeuShadow._();

  static List<BoxShadow> outer({double lift = 1}) => [
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.055),
          blurRadius: 5 * lift,
          offset: Offset(-2 * lift, -2 * lift),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.62),
          blurRadius: 28 * lift,
          spreadRadius: -7 * lift,
          offset: Offset(0, 15 * lift),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.42),
          blurRadius: 8 * lift,
          spreadRadius: -4 * lift,
          offset: Offset(0, 4 * lift),
        ),
      ];

  static List<BoxShadow> contact() => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.52),
          blurRadius: 16,
          spreadRadius: -8,
          offset: const Offset(0, 8),
        ),
      ];
}

class SkeuBevel {
  const SkeuBevel._();

  static Gradient highlight(Color base) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.28),
          base,
          Colors.black.withValues(alpha: 0.34),
        ],
        stops: const [0, 0.48, 1],
      );
}

class SkeuSurface extends StatelessWidget {
  const SkeuSurface({
    required this.child,
    this.material = SkeuMaterial.graphite,
    this.padding = const EdgeInsets.all(16),
    this.radius = 18,
    this.lift = 1,
    this.texture = true,
    super.key,
  });

  final Widget child;
  final SkeuMaterial material;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double lift;
  final bool texture;

  @override
  Widget build(BuildContext context) {
    return SkeuContainer(
      material: material,
      radius: radius,
      lift: lift,
      texture: texture,
      child: Padding(padding: padding, child: child),
    );
  }
}

class SkeuContainer extends StatelessWidget {
  const SkeuContainer({
    required this.child,
    this.material = SkeuMaterial.graphite,
    this.radius = 18,
    this.lift = 1,
    this.texture = true,
    super.key,
  });

  final Widget child;
  final SkeuMaterial material;
  final double radius;
  final double lift;
  final bool texture;

  @override
  Widget build(BuildContext context) {
    // Two RepaintBoundary layers, for two different reasons:
    //  - The outer one caches this whole surface (gradient + brushed/grain
    //    texture + inset-shadow blur stroke — the expensive part) as its own
    //    GPU layer, so it isn't re-rastered just because something ELSE on
    //    screen repaints (e.g. a sibling's scroll or an ancestor rebuild).
    //  - The inner one isolates `child` so that ITS OWN animations (a button
    //    press, the spring-driven selection capsule, an icon size tween)
    //    stop at that boundary instead of forcing the whole CustomPainter
    //    above (gradient + texture + MaskFilter.blur — all genuinely
    //    expensive Skia work) to re-run on every single animation frame.
    // Without this, every press/spring/tween anywhere in the app was
    // repainting its enclosing material's full texture+blur each frame —
    // the actual cause of the app-wide jank.
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: SkeuShadow.outer(lift: lift),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CustomPaint(
            painter: _SkeuSurfacePainter(
              material: material,
              radius: radius,
              texture: texture,
            ),
            child: RepaintBoundary(child: child),
          ),
        ),
      ),
    );
  }
}

class SkeuPressAnimation extends StatefulWidget {
  const SkeuPressAnimation({
    required this.child,
    required this.onTap,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  State<SkeuPressAnimation> createState() => _SkeuPressAnimationState();
}

class _SkeuPressAnimationState extends State<SkeuPressAnimation> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapCancel:
          widget.enabled ? () => setState(() => _pressed = false) : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onTap?.call();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _pressed ? 2.0 : 0.0, 0.0, 1.0)
          ..scaleByDouble(
            _pressed ? 0.965 : 1.0,
            _pressed ? 0.965 : 1.0,
            1.0,
            1.0,
          ),
        child: widget.child,
      ),
    );
  }
}

class SkeuButton extends StatelessWidget {
  const SkeuButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.compact = false,
    super.key,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SkeuPressAnimation(
      onTap: onTap,
      enabled: onTap != null,
      child: SkeuContainer(
        material: SkeuMaterial.aluminum,
        radius: compact ? 14 : 18,
        lift: 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 14 : 18,
            vertical: compact ? 9 : 13,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: const Color(0xFF111111)),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkeuIconButton extends StatelessWidget {
  const SkeuIconButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.size = 48,
    this.selected = false,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final button = SkeuPressAnimation(
      onTap: onTap,
      enabled: onTap != null,
      child: SizedBox.square(
        dimension: size,
        child: SkeuContainer(
          material: selected ? SkeuMaterial.aluminum : SkeuMaterial.graphite,
          radius: size / 2,
          lift: selected ? 0.85 : 0.65,
          child: Center(
            child: Icon(
              icon,
              size: size * 0.43,
              color: selected ? Colors.black : SkeuPalette.ink,
              shadows: [
                Shadow(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.9),
                  offset:
                      selected ? const Offset(-0.4, -0.4) : const Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

class SkeuAvatar extends StatelessWidget {
  const SkeuAvatar({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SkeuPressAnimation(
      onTap: onTap,
      child: SizedBox.square(
        dimension: 54,
        child: CustomPaint(
          painter: _SkeuAvatarPainter(),
          child: const Center(
            child: Icon(
              Icons.person_rounded,
              color: Color(0xFF101010),
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}

class SkeuBottomNavigation extends StatelessWidget {
  const SkeuBottomNavigation({
    required this.items,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<SkeuNavItem> items;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SkeuContainer(
      material: SkeuMaterial.aluminum,
      radius: 34,
      lift: 1.2,
      child: SizedBox(
        height: 74,
        child: Stack(
          children: [
            _SkeuSpringCapsule(
              count: items.length,
              selected: selected,
              padding: const EdgeInsets.all(8),
              radius: 26,
            ),
            Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Expanded(
                    child: SkeuPressAnimation(
                      onTap: () => onSelected(i),
                      child: _SkeuNavLabel(
                        item: items[i],
                        selected: selected == i,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The dark "pressed-in" capsule shared by [SkeuBottomNavigation] and
/// [SkeuSegmentedControl]. Its position is driven by a critically-damped
/// spring rather than a curve, for two reasons:
///
///  - An [AnimatedAlign] + [Curves.easeOutBack] previously overshot its
///    target on every move. For the first/last slot that overshoot pushed
///    the alignment past -1/+1 — the container clips at its rounded border,
///    so the capsule visibly sheared off past the frame edge.
///  - A real spring settles smoothly without that overshoot, which also
///    reads as more natural, physical motion ("moves like normal").
class _SkeuSpringCapsule extends StatefulWidget {
  const _SkeuSpringCapsule({
    required this.count,
    required this.selected,
    required this.padding,
    required this.radius,
    this.lift = 0.35,
  });

  final int count;
  final int selected;
  final EdgeInsets padding;
  final double radius;
  final double lift;

  @override
  State<_SkeuSpringCapsule> createState() => _SkeuSpringCapsuleState();
}

class _SkeuSpringCapsuleState extends State<_SkeuSpringCapsule>
    with SingleTickerProviderStateMixin {
  // Critically damped (damping = 2*sqrt(mass*stiffness)): the fastest
  // response with zero overshoot, so it can never exceed the track bounds.
  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 500,
    damping: 44.7,
  );

  late final AnimationController _controller = AnimationController.unbounded(
    vsync: this,
    value: widget.selected.toDouble(),
  );

  @override
  void didUpdateWidget(_SkeuSpringCapsule old) {
    super.didUpdateWidget(old);
    if (old.selected != widget.selected) {
      _controller.animateWith(
        SpringSimulation(
          _spring,
          _controller.value,
          widget.selected.toDouble(),
          _controller.velocity,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.count;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final pos = _controller.value.clamp(0.0, (n - 1).toDouble());
        final x = n > 1 ? (2 * pos / (n - 1)) - 1 : 0.0;
        return Align(
          alignment: Alignment(x, 0),
          child: FractionallySizedBox(
            widthFactor: 1 / n,
            child: Padding(
              padding: widget.padding,
              child: SkeuContainer(
                material: SkeuMaterial.graphite,
                radius: widget.radius,
                lift: widget.lift,
                child: const SizedBox.expand(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SkeuNavItem {
  const SkeuNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class SkeuSegmentedControl extends StatelessWidget {
  const SkeuSegmentedControl({
    required this.labels,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SkeuContainer(
      material: SkeuMaterial.aluminum,
      radius: 21,
      lift: 0.6,
      child: SizedBox(
        height: 46,
        child: Stack(
          children: [
            _SkeuSpringCapsule(
              count: labels.length,
              selected: selected,
              padding: const EdgeInsets.all(5),
              radius: 16,
              lift: 0.45,
            ),
            Row(
              children: [
                for (var i = 0; i < labels.length; i++)
                  Expanded(
                    child: SkeuPressAnimation(
                      onTap: () => onSelected(i),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 220),
                          style: TextStyle(
                            color: selected == i
                                ? SkeuPalette.ink
                                : const Color(0xFF111111),
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: selected == i
                                    ? Colors.black.withValues(alpha: 0.8)
                                    : Colors.white.withValues(alpha: 0.35),
                                offset: selected == i
                                    ? const Offset(0, 1)
                                    : const Offset(-0.4, -0.4),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(labels[i]),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkeuPageBackground extends StatelessWidget {
  const SkeuPageBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SkeuPalette.backgroundTop,
            Color(0xFF10100F),
            SkeuPalette.backgroundBottom,
          ],
        ),
      ),
      child: CustomPaint(
        painter: const _PaperNoisePainter(alpha: 0.025),
        child: child,
      ),
    );
  }
}

class _SkeuNavLabel extends StatelessWidget {
  const _SkeuNavLabel({required this.item, required this.selected});

  final SkeuNavItem item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? SkeuPalette.ink : const Color(0xFF202020);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? item.selectedIcon : item.icon,
            color: color,
            size: selected ? 25 : 23,
            shadows: [
              Shadow(
                color: selected
                    ? Colors.black.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.34),
                offset:
                    selected ? const Offset(0, 1.2) : const Offset(-0.5, -0.5),
                blurRadius: 1,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  color: selected
                      ? Colors.black.withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.3),
                  offset:
                      selected ? const Offset(0, 1) : const Offset(-0.4, -0.4),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeuSurfacePainter extends CustomPainter {
  const _SkeuSurfacePainter({
    required this.material,
    required this.radius,
    required this.texture,
  });

  final SkeuMaterial material;
  final double radius;
  final bool texture;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.save();
    canvas.clipRRect(rrect);

    // Flat, low-contrast fills — a hint of top-left lighting, never a
    // glossy diagonal sweep. Depth comes from the border/inner-shadow below.
    final gradient = switch (material) {
      SkeuMaterial.aluminum => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF95979C), SkeuPalette.aluminumDark],
        ),
      SkeuMaterial.leather => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [SkeuPalette.leatherEdge, SkeuPalette.leather],
        ),
      SkeuMaterial.paper => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFBDBFC3), SkeuPalette.paper],
        ),
      SkeuMaterial.graphite => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF292A2E), SkeuPalette.graphiteDeep],
        ),
    };
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    if (texture) _paintTexture(canvas, size, material);

    // A narrow light catch along the top edge only — not a sheen across
    // the whole surface.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x20FFFFFF), Color(0x00FFFFFF)],
          stops: [0, 0.22],
        ).createShader(rect),
    );

    canvas.drawRRect(
      rrect.deflate(1),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x77FFFFFF), Color(0x11000000), Color(0x88000000)],
        ).createShader(rect),
    );

    canvas.drawRRect(
      rrect.deflate(3),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..color = Colors.black.withValues(alpha: 0.22)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    canvas.restore();
  }

  void _paintTexture(Canvas canvas, Size size, SkeuMaterial material) {
    final paint = Paint()
      ..strokeWidth = material == SkeuMaterial.aluminum ? 0.45 : 0.35
      ..color = switch (material) {
        SkeuMaterial.aluminum => Colors.white.withValues(alpha: 0.12),
        SkeuMaterial.leather => Colors.white.withValues(alpha: 0.035),
        SkeuMaterial.paper => Colors.black.withValues(alpha: 0.025),
        SkeuMaterial.graphite => Colors.white.withValues(alpha: 0.035),
      };

    if (material == SkeuMaterial.aluminum) {
      for (var y = 2.0; y < size.height; y += 3) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y + 0.6), paint);
      }
      return;
    }

    final random = math.Random(size.width.round() * 31 + size.height.round());
    for (var i = 0; i < 220; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 0.7, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SkeuSurfacePainter oldDelegate) =>
      oldDelegate.material != material ||
      oldDelegate.radius != radius ||
      oldDelegate.texture != texture;
}

class _PaperNoisePainter extends CustomPainter {
  const _PaperNoisePainter({required this.alpha});

  final double alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()..color = Colors.white.withValues(alpha: alpha);
    for (var i = 0; i < 900; i++) {
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width,
            random.nextDouble() * size.height),
        random.nextDouble() * 0.55,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PaperNoisePainter oldDelegate) =>
      oldDelegate.alpha != alpha;
}

class _SkeuAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.shortestSide / 2;
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.1,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFF9B9C9D),
            Color(0xFF313234),
          ],
        ).createShader(rect),
    );
    canvas.drawCircle(
      center,
      radius - 6,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment.topLeft,
          radius: 0.9,
          colors: [
            Color(0xFFBFC0BE),
            Color(0xFF55575A),
            Color(0xFF141414),
          ],
        ).createShader(rect.deflate(6)),
    );
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xEEFFFFFF), Color(0x33000000), Color(0xCC000000)],
        ).createShader(rect),
    );
    canvas.drawArc(
      rect.deflate(7),
      -math.pi * 0.82,
      math.pi * 0.38,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: 0.34),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
