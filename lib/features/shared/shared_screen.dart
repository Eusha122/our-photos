import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/premium_surface.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Invite Partner',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  const Text('Create an invite code. Your partner enters it to join a two-person shared album.'),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        final invite = await ref.read(inviteServiceProvider).createInvite(
                              albumId: 'default-shared-album',
                              ownerName: 'Owner',
                            );
                        messenger.showSnackBar(
                          SnackBar(content: Text('Invite code: ${invite.code}')),
                        );
                      } catch (_) {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Invite backend is not configured yet.')),
                        );
                      }
                    },
                    icon: const Icon(Icons.add_link_rounded),
                    label: const Text('Create Code'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            PremiumSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Join With Code',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'Invite code',
                      prefixIcon: Icon(Icons.key_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () async {
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
                          const SnackBar(content: Text('Invite code could not be resolved.')),
                        );
                      }
                    },
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('Join'),
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
              ListTile(
                leading: const Icon(Icons.favorite_rounded),
                title: Text(label),
                subtitle: const Text('Synced through partner album manifests'),
              ),
          ],
        ),
      ),
    );
  }
}
