import 'package:flutter/material.dart';

import 'skeuomorphic.dart';

/// A destructive/important-action confirmation, styled to match the rest of
/// the app (a machined graphite card with an icon badge) instead of a
/// default Material [AlertDialog] — and springs in rather than just
/// appearing, matching the rest of the app's motion language.
class SkeuConfirmDialog extends StatelessWidget {
  const SkeuConfirmDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  /// Tints the icon badge and confirm label red for irreversible actions.
  final bool danger;

  /// Shows the dialog with a spring "pop" transition and returns true if the
  /// user confirmed, false/null if they cancelled or dismissed it.
  static Future<bool?> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    bool danger = false,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: title,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) =>
          SkeuConfirmDialog(
        icon: icon,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        danger: danger,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final scale = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        );
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: 0.82, end: 1.0).animate(scale),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = danger ? const Color(0xFFE8505B) : SkeuPalette.titanium;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: SkeuSurface(
        material: SkeuMaterial.graphite,
        radius: 22,
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SizedBox.square(
                dimension: 56,
                child: SkeuContainer(
                  material: SkeuMaterial.aluminum,
                  radius: 28,
                  child: Icon(icon,
                      color: accent == SkeuPalette.titanium
                          ? const Color(0xFF111111)
                          : accent,
                      size: 26),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: SkeuPalette.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: SkeuPalette.muted, fontSize: 14),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: SkeuButton(
                    label: cancelLabel,
                    compact: true,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SkeuButton(
                    label: confirmLabel,
                    compact: true,
                    onTap: () => Navigator.of(context).pop(true),
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
