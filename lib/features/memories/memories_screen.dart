import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../models/timeline_bucket.dart' as domain;
import '../../widgets/skeuomorphic.dart';
import '../photos/asset_group_screen.dart';
import '../photos/asset_thumbnail.dart';
import '../photos/asset_tile.dart';

class MemoriesScreen extends ConsumerWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: FutureBuilder<List<domain.TimelineBucket>>(
          future: ref.watch(galleryRepositoryProvider).loadMemories(),
          builder: (context, snapshot) {
            final groups = snapshot.data ?? const <domain.TimelineBucket>[];
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: groups.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Memories',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (groups.isEmpty &&
                            snapshot.connectionState == ConnectionState.done)
                          const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'Memories appear here once your photos are '
                              'indexed.',
                              style: TextStyle(
                                color: SkeuPalette.muted,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return _MemoryCard(group: groups[index - 1]);
              },
            );
          },
        ),
      ),
    );
  }
}

/// A memory card with a real cover photo from the group and its actual
/// photo count — tapping opens every photo in that group.
class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.group});

  final domain.TimelineBucket group;

  @override
  Widget build(BuildContext context) {
    final cover = group.assets.isEmpty ? null : group.assets.first;
    return Pressable(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => AssetGroupScreen(
            title: group.title,
            assets: group.assets,
          ),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: SkeuShadow.contact(),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 132,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: SkeuPalette.graphiteDeep),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (cover != null)
                    Image(
                      image: AssetThumbnailProvider(cover.platformId),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      errorBuilder: (context, error, stack) =>
                          const SizedBox.shrink(),
                    ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.35, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          group.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${group.assets.length} '
                          '${group.assets.length == 1 ? 'photo' : 'photos'}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
