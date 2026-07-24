import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Apple iOS 26 "Liquid Glass" material.
///
/// This is **not** a single translucent container. It is a stack of optical
/// layers that together read as a thick slab of illuminated acrylic:
///
///  1. Backdrop blur  — refracts ONLY the content behind the glass.
///  2. Dynamic tint   — a light-adaptive fill that gives the slab body.
///  3. Specular sweep — a bright band that slowly travels across the surface.
///  4. Top highlight  — a bright gradient along the upper edge.
///  5. Inner shadow   — darkened inner rim that implies real thickness.
///  6. Edge bloom + hairline border — the rim catches and holds light.
///  7. Content        — never blurred; always crisp above the material.
///
/// The expensive [BackdropFilter] is built once and isolated in a
/// [RepaintBoundary]; only the lightweight vector light-layers repaint as the
/// reflections drift, so the blur layer is never rebuilt.
class LiquidGlass extends StatefulWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.padding = EdgeInsets.zero,
    this.blur = 24,
    this.animate = true,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;

  /// Whether the specular sweep / reflections drift. Disable for small chrome.
  final bool animate;

  @override
  State<LiquidGlass> createState() => _LiquidGlassState();
}

class _LiquidGlassState extends State<LiquidGlass>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drift;

  @override
  void initState() {
    super.initState();
    _drift = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );
    if (widget.animate) _drift.repeat();
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(widget.borderRadius);

    return DecoratedBox(
      // Layer 9: extremely soft, layered ambient shadow — no Material elevation.
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.55 : 0.18),
            blurRadius: 44,
            spreadRadius: -10,
            offset: const Offset(0, 22),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.3 : 0.08),
            blurRadius: 14,
            spreadRadius: -8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            // Layers 1 + 2: backdrop blur + dynamic tint. Built ONCE.
            Positioned.fill(
              child: RepaintBoundary(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blur,
                    sigmaY: widget.blur,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: dark
                            ? [
                                Colors.white.withValues(alpha: 0.12),
                                Colors.white.withValues(alpha: 0.04),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.34),
                                Colors.white.withValues(alpha: 0.16),
                              ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Layers 3-6: specular, highlight, inner shadow, bloom, border.
            // Isolated repaint; the blur above is untouched.
            Positioned.fill(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _drift,
                  builder: (context, _) => CustomPaint(
                    painter: _LiquidGlassPainter(
                      t: _drift.value,
                      radius: widget.borderRadius,
                      dark: dark,
                    ),
                  ),
                ),
              ),
            ),
            // Layer 7: content — above all glass, never blurred.
            Padding(padding: widget.padding, child: widget.child),
          ],
        ),
      ),
    );
  }
}

class _LiquidGlassPainter extends CustomPainter {
  _LiquidGlassPainter({
    required this.t,
    required this.radius,
    required this.dark,
  });

  final double t;
  final double radius;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    canvas.save();
    canvas.clipRRect(rrect);

    // Layer 4: top highlight gradient — light pools along the upper edge.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: dark ? 0.24 : 0.5),
            Colors.white.withValues(alpha: 0),
          ],
          stops: const [0, 0.5],
        ).createShader(rect),
    );

    // Moving reflections: two soft radial pools drifting on slow phases.
    const tau = 2 * math.pi;
    _pool(
      canvas,
      size,
      center: Offset(
        size.width * (0.3 + 0.35 * math.sin(tau * t)),
        size.height * (0.15 + 0.25 * math.cos(tau * t)),
      ),
      radius: size.height * 1.6,
      alpha: dark ? 0.10 : 0.22,
    );
    _pool(
      canvas,
      size,
      center: Offset(
        size.width * (0.72 - 0.32 * math.sin(tau * (t + 0.4))),
        size.height * (0.85 - 0.3 * math.sin(tau * t)),
      ),
      radius: size.height * 1.3,
      alpha: dark ? 0.07 : 0.15,
    );

    // Layer 3: specular sweep — a narrow bright band travelling diagonally.
    final band = (t * 1.0) % 1.0;
    final c0 = (band - 0.10).clamp(0.0, 1.0);
    final c1 = band.clamp(0.0, 1.0);
    final c2 = (band + 0.10).clamp(0.0, 1.0);
    canvas.drawRect(
      rect,
      Paint()
        ..blendMode = BlendMode.plus
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: dark ? 0.14 : 0.28),
            Colors.white.withValues(alpha: 0),
          ],
          stops: [c0, c1, c2],
        ).createShader(rect),
    );

    // Layer 5: inner shadow — a blurred dark rim inside the edge gives the
    // slab real thickness (the core of "acrylic, not plastic").
    canvas.drawRRect(
      rrect.deflate(1),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..color = Colors.black.withValues(alpha: dark ? 0.5 : 0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Layer 6a: edge bloom — a soft inner glow so the rim holds light.
    canvas.drawRRect(
      rrect.deflate(1.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = Colors.white.withValues(alpha: dark ? 0.32 : 0.55)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5),
    );

    canvas.restore();

    // Layer 6b: crisp hairline border — brightest top-left, fading away.
    canvas.drawRRect(
      rrect.deflate(0.6),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: dark ? 0.55 : 0.95),
            Colors.white.withValues(alpha: dark ? 0.06 : 0.25),
          ],
        ).createShader(rect),
    );
  }

  void _pool(
    Canvas canvas,
    Size size, {
    required Offset center,
    required double radius,
    required double alpha,
  }) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..blendMode = BlendMode.plus
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: alpha),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassPainter old) =>
      old.t != t || old.dark != dark || old.radius != radius;
}

/// The bright floating capsule that sits *inside* a [LiquidGlass] dock/segment
/// to mark the selection — glass-on-glass, with its own bloom and highlight.
/// It carries no backdrop filter (the parent already refracts the background),
/// so there is no costly nested blur.
class LiquidGlassCapsule extends StatelessWidget {
  const LiquidGlassCapsule({super.key, this.radius = 22});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final r = BorderRadius.circular(radius);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: r,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? [
                  Colors.white.withValues(alpha: 0.30),
                  Colors.white.withValues(alpha: 0.12),
                ]
              : [
                  Colors.white.withValues(alpha: 0.92),
                  Colors.white.withValues(alpha: 0.6),
                ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: dark ? 0.4 : 0.95),
          width: 1,
        ),
        boxShadow: [
          // Edge bloom — the capsule glows against the darker dock.
          BoxShadow(
            color: Colors.white.withValues(alpha: dark ? 0.14 : 0.5),
            blurRadius: 14,
            spreadRadius: -1,
          ),
          // Soft lift.
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.4 : 0.14),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        // A subtle top specular streak on the capsule itself.
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Colors.white.withValues(alpha: dark ? 0.22 : 0.6),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A selector built on the same glass material: a [LiquidGlass] shell with a
/// spring-driven [LiquidGlassCapsule] that *morphs* (slides) between items
/// instead of cross-fading. Used by both the dock and the segmented control.
class GlassSelector extends StatefulWidget {
  const GlassSelector({
    super.key,
    required this.count,
    required this.selected,
    required this.onSelected,
    required this.itemBuilder,
    this.height = 60,
    this.borderRadius = 32,
    this.capsuleRadius = 22,
    this.outerPadding = const EdgeInsets.all(8),
    this.capsuleInset = 3,
    this.blur = 26,
  });

  final int count;
  final int selected;
  final ValueChanged<int> onSelected;
  final Widget Function(BuildContext context, int index, bool selected)
      itemBuilder;
  final double height;
  final double borderRadius;
  final double capsuleRadius;
  final EdgeInsets outerPadding;
  final double capsuleInset;
  final double blur;

  @override
  State<GlassSelector> createState() => _GlassSelectorState();
}

class _GlassSelectorState extends State<GlassSelector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pos;

  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 520,
    damping: 30,
  );

  @override
  void initState() {
    super.initState();
    _pos = AnimationController.unbounded(
      vsync: this,
      value: widget.selected.toDouble(),
    );
  }

  @override
  void didUpdateWidget(GlassSelector old) {
    super.didUpdateWidget(old);
    if (old.selected != widget.selected) {
      _pos.animateWith(
        SpringSimulation(
          _spring,
          _pos.value,
          widget.selected.toDouble(),
          _pos.velocity,
        ),
      );
    }
  }

  @override
  void dispose() {
    _pos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      borderRadius: widget.borderRadius,
      blur: widget.blur,
      padding: widget.outerPadding,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            // The spring-morphing selection capsule.
            AnimatedBuilder(
              animation: _pos,
              builder: (context, _) {
                final clamped =
                    _pos.value.clamp(0.0, (widget.count - 1).toDouble());
                final frac = (clamped + 0.5) / widget.count;
                return Align(
                  alignment: Alignment(frac * 2 - 1, 0),
                  child: FractionallySizedBox(
                    widthFactor: 1 / widget.count,
                    child: Padding(
                      padding: EdgeInsets.all(widget.capsuleInset),
                      child: LiquidGlassCapsule(radius: widget.capsuleRadius),
                    ),
                  ),
                );
              },
            ),
            // Crisp content row above the capsule.
            Row(
              children: [
                for (var i = 0; i < widget.count; i++)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => widget.onSelected(i),
                      child: widget.itemBuilder(context, i, i == widget.selected),
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
