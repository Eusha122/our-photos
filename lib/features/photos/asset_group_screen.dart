import 'package:flutter/material.dart';

import '../../models/gallery_asset.dart';
import '../../widgets/skeuomorphic.dart';
import 'asset_tile.dart';
import 'media_viewer.dart';

/// Full-screen grid for "everything inside one group" — an album, a
/// timeline bucket, or a memory. Tapping a tile opens the same full-screen
/// viewer used from the main Photos grid, scoped to just this group's
/// assets (so swiping through the viewer stays within the group).
class AssetGroupScreen extends StatelessWidget {
  const AssetGroupScreen({
    super.key,
    required this.title,
    required this.assets,
  });

  final String title;
  final List<GalleryAsset> assets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkeuPageBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  children: [
                    SkeuIconButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: 'Back',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: SkeuPalette.ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16 + 48 + 14),
                child: Text(
                  '${assets.length} ${assets.length == 1 ? 'item' : 'items'}',
                  style: const TextStyle(
                    color: SkeuPalette.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: assets.isEmpty
                    ? const Center(
                        child: Text(
                          'Nothing here yet.',
                          style: TextStyle(color: SkeuPalette.muted),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 130,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: assets.length,
                        itemBuilder: (context, index) => AssetTile(
                          asset: assets[index],
                          onOpen: () => Navigator.of(context).push(
                            mediaViewerRoute(
                              assets: assets,
                              initialIndex: index,
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
