import 'package:flutter/material.dart';

import '../../widgets/premium_surface.dart';
import '../../widgets/skeuomorphic.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      'On This Day',
      'This Week',
      'Last Month',
      'Summer Memories',
      'Vacation Memories',
      'Birthday Memories',
      'Weekend Memories',
      'Best Photos of the Month',
      'Recently Added',
      'Recently Edited',
    ];
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: sections.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Text(
                'Memories',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
              );
            }
            final title = sections[index - 1];
            return PremiumSurface(
              material: SkeuMaterial.leather,
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                height: 132,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Text(
                        'Local slideshow • Ken Burns • MP4 export ready'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
