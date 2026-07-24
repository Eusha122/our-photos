import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/gallery_asset.dart';
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
  bool _busy = false;

  void _toggle(String assetId) {
    setState(() {
      if (!_selected.remove(assetId)) _selected.add(assetId);
    });
  }

  Future<void> _restoreSelected() async {
    final ids = _selected.toList();
    setState(() => _busy = true);
    final repo = ref.read(galleryRepositoryProvider);
    for (final id in ids) {
      await repo.restoreFromTrash(id);
    }
    if (!mounted) return;
    setState(() {
      _selected.clear();
      _busy = false;
    });
  }

  Future<void> _deleteForeverSelected(List<GalleryAsset> allTrashed) async {
    final targets = allTrashed.where((a) => _selected.contains(a.id)).toList();
    if (targets.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _ConfirmDialog(
        title: 'Delete forever?',
        message: targets.length == 1
            ? 'This photo will be permanently removed from your device. '
                "This can't be undone."
            : 'These ${targets.length} items will be permanently removed '
                "from your device. This can't be undone.",
        confirmLabel: 'Delete Forever',
      ),
    );
    if (confirmed != true) return;

    setState(() => _busy = true);
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
              'Items stay here until you delete them permanently.',
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
                      Row(
                        children: [
                          Expanded(
                            child: SkeuButton(
                              icon: Icons.restore_rounded,
                              label: 'Restore',
                              onTap: _busy || _selected.isEmpty
                                  ? null
                                  : _restoreSelected,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SkeuButton(
                              icon: Icons.delete_forever_rounded,
                              label: 'Delete Forever',
                              onTap: _busy || _selected.isEmpty
                                  ? null
                                  : () => _deleteForeverSelected(assets),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
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
                            final selected = _selected.contains(asset.id);
                            return _TrashTile(
                              asset: asset,
                              selected: selected,
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
    required this.onTap,
  });

  final GalleryAsset asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: SkeuPalette.graphiteDeep),
              child: Opacity(
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
          if (selected)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: SkeuPalette.titanium, width: 3),
                ),
              ),
            ),
          Positioned(
            top: 6,
            right: 6,
            child: SizedBox.square(
              dimension: 26,
              child: SkeuContainer(
                material:
                    selected ? SkeuMaterial.aluminum : SkeuMaterial.graphite,
                radius: 13,
                lift: 0.5,
                texture: false,
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Color(0xFF111111),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A destructive-action confirmation, styled to match the rest of the app
/// (a machined graphite card) instead of a default Material [AlertDialog].
class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: SkeuSurface(
        material: SkeuMaterial.graphite,
        radius: 20,
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: SkeuPalette.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: SkeuPalette.muted, fontSize: 14),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: SkeuButton(
                    label: 'Cancel',
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
