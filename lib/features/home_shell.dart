import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/liquid_glass.dart';
import 'backup/backup_screen.dart';
import 'memories/memories_screen.dart';
import 'photos/gallery_index_controller.dart';
import 'photos/photos_screen.dart';
import 'settings/settings_screen.dart';
import 'shared/shared_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _index = 0;

  final _screens = const [
    PhotosScreen(),
    MemoriesScreen(),
    SharedScreen(),
    BackupScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Begin indexing after the first frame so the UI is never blocked by
    // permission prompts or the initial gallery scan.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(galleryIndexControllerProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 360),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _screens[_index],
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: IconButton.filledTonal(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.person_rounded),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: LiquidGlass(
          borderRadius: 28,
          blur: 26,
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            selectedIndex: _index,
            height: 72,
            onDestinationSelected: (value) => setState(() => _index = value),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.photo_library_outlined),
                selectedIcon: Icon(Icons.photo_library_rounded),
                label: 'Photos',
              ),
              NavigationDestination(
                icon: Icon(Icons.auto_awesome_motion_outlined),
                selectedIcon: Icon(Icons.auto_awesome_motion_rounded),
                label: 'Memories',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded),
                selectedIcon: Icon(Icons.favorite_rounded),
                label: 'Shared',
              ),
              NavigationDestination(
                icon: Icon(Icons.cloud_queue_rounded),
                selectedIcon: Icon(Icons.cloud_done_rounded),
                label: 'Backup',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
