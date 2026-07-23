import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home_shell.dart';
import 'theme/memoryvault_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MemoryVaultApp()));
}

class MemoryVaultApp extends StatelessWidget {
  const MemoryVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemoryVault',
      themeMode: ThemeMode.system,
      theme: MemoryVaultTheme.light(),
      darkTheme: MemoryVaultTheme.dark(),
      home: const HomeShell(),
    );
  }
}
