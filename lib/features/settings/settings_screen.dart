import 'package:flutter/material.dart';

import '../../widgets/skeuomorphic.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      ('Theme', Icons.palette_rounded),
      ('Backup', Icons.cloud_done_rounded),
      ('Storage', Icons.sd_storage_rounded),
      ('Permissions', Icons.privacy_tip_rounded),
      ('Face Detection', Icons.face_rounded),
      ('OCR', Icons.document_scanner_rounded),
      ('Memory Generation', Icons.auto_awesome_motion_rounded),
      ('Developer', Icons.terminal_rounded),
      ('About', Icons.info_rounded),
    ];
    return Scaffold(
      body: SkeuPageBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SkeuIconButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: 'Back',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: SkeuPalette.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: settings.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final (title, icon) = settings[index];
                      return SkeuPressAnimation(
                        onTap: () {},
                        child: SkeuSurface(
                          material: SkeuMaterial.graphite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 13,
                          ),
                          child: Row(
                            children: [
                              Icon(icon, color: SkeuPalette.titanium),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: SkeuPalette.ink,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: SkeuPalette.muted,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
