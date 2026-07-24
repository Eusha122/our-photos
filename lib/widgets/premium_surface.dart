import 'package:flutter/material.dart';

import 'skeuomorphic.dart';

class PremiumSurface extends StatelessWidget {
  const PremiumSurface({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.material = SkeuMaterial.graphite,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final SkeuMaterial material;

  @override
  Widget build(BuildContext context) {
    return SkeuSurface(
      material: material,
      padding: padding,
      child: child,
    );
  }
}
