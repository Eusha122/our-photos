import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/skeuomorphic.dart';
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

  static const _navItems = [
    SkeuNavItem(
      icon: Icons.photo_library_outlined,
      selectedIcon: Icons.photo_library_rounded,
      label: 'Photos',
    ),
    SkeuNavItem(
      icon: Icons.auto_awesome_motion_outlined,
      selectedIcon: Icons.auto_awesome_motion_rounded,
      label: 'Memories',
    ),
    SkeuNavItem(
      icon: Icons.favorite_border_rounded,
      selectedIcon: Icons.favorite_rounded,
      label: 'Shared',
    ),
    SkeuNavItem(
      icon: Icons.cloud_queue_rounded,
      selectedIcon: Icons.cloud_done_rounded,
      label: 'Backup',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(galleryIndexControllerProvider.notifier).start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: SkeuPageBackground(child: SizedBox.expand()),
          ),
          // Each screen lays its own content full-bleed and reserves its own
          // top/bottom padding for the dock and (on Photos) its collapsing
          // header, so scrolled content passes genuinely *behind* the
          // floating chrome instead of stopping in a dead gutter above it.
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _screens[_index],
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            right: 16,
            child: SkeuAvatar(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SettingsScreen(),
                ),
              ),
            ),
          ),
          // Bottom dock: always floating, always visible — a persistent
          // anchor over the content, like Photos/Google Photos.
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: RepaintBoundary(
              child: SkeuBottomNavigation(
                items: _navItems,
                selected: _index,
                onSelected: (value) => setState(() => _index = value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
