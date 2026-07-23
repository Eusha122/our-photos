import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Settings')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: settings.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final (title, icon) = settings[index];
          return ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: const Icon(Icons.chevron_right_rounded),
          );
        },
      ),
    );
  }
}
