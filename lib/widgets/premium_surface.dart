import 'dart:ui';

import 'package:flutter/material.dart';

class PremiumSurface extends StatelessWidget {
  const PremiumSurface({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surfaceContainerHighest.withOpacity(0.9),
            scheme.surface.withOpacity(0.68),
          ],
        ),
        border: Border.all(color: scheme.outlineVariant.withOpacity(0.32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.03 : 0.72,
            ),
            blurRadius: 18,
            offset: const Offset(-6, -8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
