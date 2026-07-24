import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/premium_surface.dart';
import '../../widgets/skeuomorphic.dart';

class SharedScreen extends ConsumerStatefulWidget {
  const SharedScreen({super.key});

  @override
  ConsumerState<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends ConsumerState<SharedScreen> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              'Shared',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            PremiumSurface(
              material: SkeuMaterial.leather,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Invite Partner',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'Create an invite code. Your partner enters it to join a two-person shared album.'),
                  const SizedBox(height: 14),
                  SkeuButton(
                    icon: Icons.add_link_rounded,
                    label: 'Create Code',
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        final invite =
                            await ref.read(inviteServiceProvider).createInvite(
                                  albumId: 'default-shared-album',
                                  ownerName: 'Owner',
                                );
                        messenger.showSnackBar(
                          SnackBar(
                              content: Text('Invite code: ${invite.code}')),
                        );
                      } catch (_) {
                        messenger.showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Invite backend is not configured yet.')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            PremiumSurface(
              material: SkeuMaterial.leather,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Join With Code',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  SkeuSurface(
                    material: SkeuMaterial.graphite,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _codeController,
                      style: const TextStyle(
                        color: SkeuPalette.ink,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Invite code',
                        labelStyle: TextStyle(color: SkeuPalette.muted),
                        prefixIcon: Icon(
                          Icons.key_rounded,
                          color: SkeuPalette.titanium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SkeuButton(
                    icon: Icons.login_rounded,
                    label: 'Join',
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        final invite = await ref
                            .read(inviteServiceProvider)
                            .resolveInvite(_codeController.text.trim());
                        messenger.showSnackBar(
                          SnackBar(content: Text('Joined ${invite.ownerName}')),
                        );
                      } catch (_) {
                        messenger.showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Invite code could not be resolved.')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            for (final label in const [
              'Shared albums',
              'Shared memories',
              'Comments',
              'Reactions',
              'Shared notes',
              'Shared timeline',
              'Shared favorites',
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SkeuSurface(
                  material: SkeuMaterial.graphite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: SkeuPalette.titanium,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'Synced through partner album manifests',
                              style: TextStyle(
                                color: SkeuPalette.muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
