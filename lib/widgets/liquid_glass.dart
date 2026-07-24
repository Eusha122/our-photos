import 'dart:ui';

import 'package:flutter/material.dart';

/// A frosted "liquid glass" surface: real backdrop blur, a translucent tint,
/// a bright hairline edge and a soft shadow. Used for the app chrome so
/// content scrolls smoothly *behind* the glass.
class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.padding = EdgeInsets.zero,
    this.blur = 24,
    this.opacity = 1,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;

  /// Multiplies the tint/border strength, e.g. to fade the whole panel in.
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(borderRadius);
    final fillTop = (dark ? 0.14 : 0.62) * opacity;
    final fillBottom = (dark ? 0.05 : 0.34) * opacity;
    final edge = (dark ? 0.18 : 0.7) * opacity;

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: fillTop),
                Colors.white.withValues(alpha: fillBottom),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: edge),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: dark ? 0.34 : 0.12),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
