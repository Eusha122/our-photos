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
  bool _navVisible = true;

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

  // Scrolling down (content moving up, scrollDelta > 0) hides the dock;
  // scrolling up brings it back. A small threshold ignores the tiny deltas
  // from bounce/rubber-banding at the list ends so it doesn't flicker.
  bool _handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta;
      if (delta == null || delta.abs() < 3) return false;
      final shouldShow = delta < 0;
      if (shouldShow != _navVisible) {
        setState(() => _navVisible = shouldShow);
      }
    } else if (notification is ScrollEndNotification) {
      final metrics = notification.metrics;
      if (metrics.pixels <= metrics.minScrollExtent && !_navVisible) {
        setState(() => _navVisible = true);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScroll,
        child: Stack(
          children: [
            const Positioned.fill(
              child: SkeuPageBackground(child: SizedBox.expand()),
            ),
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
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: RepaintBoundary(
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  offset: _navVisible ? Offset.zero : const Offset(0, 1.6),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _navVisible ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: !_navVisible,
                      child: SkeuBottomNavigation(
                        items: _navItems,
                        selected: _index,
                        onSelected: (value) => setState(() {
                          _index = value;
                          _navVisible = true;
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
