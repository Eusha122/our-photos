import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemoryVaultTheme {
  static ThemeData light() {
    return _base(
      brightness: Brightness.light,
      surface: const Color(0xFFF7F3EC),
      onSurface: const Color(0xFF171412),
      accent: const Color(0xFF0D7C66),
      secondary: const Color(0xFFE8505B),
    );
  }

  static ThemeData dark() {
    return _base(
      brightness: Brightness.dark,
      surface: const Color(0xFF111111),
      onSurface: const Color(0xFFF7F1E8),
      accent: const Color(0xFF62D2A2),
      secondary: const Color(0xFFFFB000),
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
      useMaterial3: true,
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
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        indicatorColor: accent.withValues(alpha: 0.18),
        backgroundColor: surface.withValues(alpha: 0.86),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.72),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
