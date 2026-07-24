import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/skeuomorphic.dart';
import '../photos/asset_thumbnail.dart';
import '../photos/gallery_index_controller.dart';

class TrashScreen extends ConsumerStatefulWidget {
  const TrashScreen({super.key});

  @override
  ConsumerState<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends ConsumerState<TrashScreen> {
  final Set<String> _selected = {};
  final Set<String> _removingIds = {};
  final _auth = LocalAuthentication();
  bool _busy = false;

  void _toggle(String assetId) {
    HapticFeedback.selectionClick();
    setState(() {
      if (!_selected.remove(assetId)) _selected.add(assetId);
    });
  }

  Future<void> _restoreSelected() async {
    final ids = _selected.toList();
    setState(() {
      _removingIds.addAll(ids);
      _selected.clear();
      _busy = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;
    final repo = ref.read(galleryRepositoryProvider);
    for (final id in ids) {
      await repo.restoreFromTrash(id);
    }
    if (!mounted) return;
    setState(() {
      _removingIds.removeAll(ids);
      _busy = false;
    });
  }

  /// Requires the device's own lock — password, fingerprint, or face — before
  /// a permanent, unrecoverable deletion can even be attempted. Falls back to
  /// device credentials (not just biometrics) since not every phone has
  /// fingerprint/face set up, matching what was asked for.
  Future<bool> _authenticate() async {
    try {
      final canCheck =
          await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
      if (!canCheck) return true; // No lock configured on this device at all.
      return await _auth.authenticate(
        localizedReason: 'Confirm to permanently delete',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> _deleteForeverSelected(List<GalleryAsset> allTrashed) async {
    final targets = allTrashed.where((a) => _selected.contains(a.id)).toList();
    if (targets.isEmpty) return;

    final authenticated = await _authenticate();
    if (!authenticated) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication required to delete.')),
      );
      return;
    }
    if (!mounted) return;

    final confirmed = await SkeuConfirmDialog.show(
      context,
      icon: Icons.warning_amber_rounded,
      title: 'Gone forever',
      danger: true,
      message: targets.length == 1
          ? 'This photo will be permanently erased from your device. '
              "You won't be able to get it back."
          : 'These ${targets.length} items will be permanently erased '
              "from your device. You won't be able to get them back.",
      confirmLabel: 'Delete',
    );
    if (confirmed != true) return;

    setState(() {
      _removingIds.addAll(_selected);
      _busy = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;

    final indexer = ref.read(mediaIndexerProvider);
    final repo = ref.read(galleryRepositoryProvider);

    // The OS shows its own confirmation for the actual device deletion; the
    // user may decline some or all of it, so only rows that were genuinely
    // removed from the device are cleared from our own database.
    final deletedPlatformIds = await indexer.deleteFromDevice(
      targets.map((a) => a.platformId).toList(),
    );
    final deletedIds = targets
        .where((a) => deletedPlatformIds.contains(a.platformId))
        .map((a) => a.id)
        .toList();
    await repo.permanentlyDeleteRows(deletedIds);

    if (!mounted) return;
    setState(() {
      _selected.removeAll(deletedIds);
      _removingIds.removeAll(deletedIds);
      _busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trash = ref.watch(trashStreamProvider);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Trash',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'Items are deleted forever after 20 days.',
              style: TextStyle(color: SkeuPalette.muted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: trash.when(
                error: (_, __) => const Center(
                  child: Text(
                    'Could not load trash.',
                    style: TextStyle(color: SkeuPalette.muted),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: SkeuPalette.titanium),
                ),
                data: (assets) {
                  if (assets.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 40,
                            color: SkeuPalette.muted,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Trash is empty',
                            style: TextStyle(
                              color: SkeuPalette.muted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _selected.isEmpty ? 0 : 1,
                          child: _selected.isEmpty
                              ? const SizedBox(width: double.infinity)
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SkeuButton(
                                          icon: Icons.restore_rounded,
                                          label: 'Restore',
                                          onTap:
                                              _busy ? null : _restoreSelected,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SkeuButton(
                                          icon: Icons.delete_forever_rounded,
                                          label: 'Delete Forever',
                                          onTap: _busy
                                              ? null
                                              : () => _deleteForeverSelected(
                                                  assets),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 130,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: assets.length,
                          itemBuilder: (context, index) {
                            final asset = assets[index];
                            return _TrashTile(
                              asset: asset,
                              selected: _selected.contains(asset.id),
                              removing: _removingIds.contains(asset.id),
                              onTap: () => _toggle(asset.id),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrashTile extends StatelessWidget {
  const _TrashTile({
    required this.asset,
    required this.selected,
    required this.removing,
    required this.onTap,
  });

  final GalleryAsset asset;
  final bool selected;
  final bool removing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: removing ? 0.55 : (selected ? 1.05 : 1),
        duration: Duration(milliseconds: removing ? 220 : 260),
        curve: removing ? Curves.easeInCubic : Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: removing ? 0 : 1,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInCubic,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: DecoratedBox(
                  decoration:
                      const BoxDecoration(color: SkeuPalette.graphiteDeep),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 160),
                    opacity: selected ? 0.5 : 1,
                    child: Image(
                      image: AssetThumbnailProvider(asset.platformId),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      errorBuilder: (context, error, stack) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: selected ? 1 : 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: SkeuPalette.titanium, width: 3),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: SizedBox.square(
                  dimension: 26,
                  child: SkeuContainer(
                    material: selected
                        ? SkeuMaterial.aluminum
                        : SkeuMaterial.graphite,
                    radius: 13,
                    lift: 0.5,
                    texture: false,
                    child: AnimatedScale(
                      scale: selected ? 1 : 0,
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutBack,
                      child: const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
