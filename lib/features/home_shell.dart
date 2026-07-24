import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/liquid_glass.dart';
import 'backup/backup_screen.dart';
import 'memories/memories_screen.dart';
import 'photos/gallery_index_controller.dart';
import 'photos/photos_screen.dart';
import 'settings/settings_screen.dart';
import 'shared/shared_screen.dart';

class _NavItem {
  const _NavItem(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

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
    _NavItem(Icons.photo_library_outlined, Icons.photo_library_rounded,
        'Photos'),
    _NavItem(Icons.auto_awesome_motion_outlined,
        Icons.auto_awesome_motion_rounded, 'Memories'),
    _NavItem(Icons.favorite_border_rounded, Icons.favorite_rounded, 'Shared'),
    _NavItem(Icons.cloud_queue_rounded, Icons.cloud_done_rounded, 'Backup'),
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
      // No bottomNavigationBar: the dock floats freely over the content.
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 360),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _screens[_index],
          ),
          // Glass settings button.
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            right: 16,
            child: LiquidGlass(
              borderRadius: 26,
              blur: 20,
              animate: false,
              child: IconButton(
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
          // Floating Liquid Glass dock — 18px clear of every edge.
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: RepaintBoundary(
              child: GlassSelector(
                count: _navItems.length,
                selected: _index,
                onSelected: (value) => setState(() => _index = value),
                height: 58,
                borderRadius: 34,
                capsuleRadius: 24,
                outerPadding: const EdgeInsets.all(7),
                blur: 30,
                itemBuilder: (context, i, selected) =>
                    _DockItem(item: _navItems[i], selected: selected),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  const _DockItem({required this.item, required this.selected});

  final _NavItem item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final color = selected
        ? (dark ? Colors.white : const Color(0xFF171412))
        : scheme.onSurface.withValues(alpha: 0.6);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: selected ? 1 : 0),
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          builder: (context, t, _) => Icon(
            selected ? item.selectedIcon : item.icon,
            color: color,
            size: 23 + 2 * t,
          ),
        ),
        const SizedBox(height: 3),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 220),
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
            color: color,
          ),
          child: Text(item.label),
        ),
      ],
    );
  }
}
