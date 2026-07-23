import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/premium_surface.dart';

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
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline_rounded),
                    title: Text(step),
                    subtitle: const Text('Background queue stage'),
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
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
