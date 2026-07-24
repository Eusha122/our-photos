import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/premium_surface.dart';
import '../../widgets/skeuomorphic.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(galleryRepositoryProvider);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 96),
        child: StreamBuilder(
          stream: repository.watchBackupJobs(),
          builder: (context, snapshot) {
            final jobs = snapshot.data ?? const [];
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text(
                  'Backup',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                const PremiumSurface(
                  material: SkeuMaterial.leather,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Backblaze B2',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      Text(
                          'Backup is explicit and queue based. Nothing uploads until you enable B2 and queue items.'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _MetricRow(
                  storageUsed: '0 GB',
                  pending: jobs.length,
                  failed: jobs.where((job) => job.state == 'failed').length,
                ),
                const SizedBox(height: 14),
                for (final step in const [
                  'Photo Added',
                  'Queue',
                  'Thumbnail',
                  'Hash',
                  'Upload',
                  'Verify',
                  'Done',
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
                            Icons.check_circle_outline_rounded,
                            color: SkeuPalette.titanium,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  'Background queue stage',
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
            );
          },
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.storageUsed,
    required this.pending,
    required this.failed,
  });

  final String storageUsed;
  final int pending;
  final int failed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Metric(label: 'Storage Used', value: storageUsed)),
        const SizedBox(width: 10),
        Expanded(child: _Metric(label: 'Pending', value: '$pending')),
        const SizedBox(width: 10),
        Expanded(child: _Metric(label: 'Failed', value: '$failed')),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return PremiumSurface(
      material: SkeuMaterial.aluminum,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                color: Color(0xFF080808),
                fontSize: 21,
                fontWeight: FontWeight.w900,
              )),
        ],
      ),
    );
  }
}
