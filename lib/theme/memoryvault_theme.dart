import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/skeuomorphic.dart';

class MemoryVaultTheme {
  static ThemeData light() {
    return dark();
  }

  static ThemeData dark() {
    return _base(
      brightness: Brightness.dark,
      surface: SkeuPalette.backgroundBottom,
      onSurface: SkeuPalette.ink,
      accent: SkeuPalette.titanium,
      secondary: SkeuPalette.aluminum,
    );
  }

  static ThemeData _base({
    required Brightness brightness,
    required Color surface,
    required Color onSurface,
    required Color accent,
    required Color secondary,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      surface: surface,
      onSurface: onSurface,
      secondary: secondary,
    );
    return ThemeData(
      useMaterial3: false,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      fontFamily: 'SF Pro Display',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: SkeuPalette.ink,
        ),
        bodyMedium: TextStyle(color: SkeuPalette.ink),
      ),
    );
  }
}
