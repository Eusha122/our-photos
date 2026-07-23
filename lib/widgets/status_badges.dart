import 'package:flutter/material.dart';

import '../models/media_status.dart';

class StatusBadges extends StatelessWidget {
  const StatusBadges({required this.statuses, super.key});

  final Set<MediaStatus> statuses;

  @override
  Widget build(BuildContext context) {
    final visible = statuses.take(4).toList();
    return Wrap(
      spacing: 3,
      children: [
        for (final status in visible)
          Tooltip(
            message: status.label,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.48),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(_icon(status), size: 11, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  IconData _icon(MediaStatus status) {
    return switch (status) {
      MediaStatus.local => Icons.phone_iphone_rounded,
      MediaStatus.backedUp => Icons.cloud_done_rounded,
      MediaStatus.shared => Icons.favorite_rounded,
      MediaStatus.uploading => Icons.upload_rounded,
      MediaStatus.failed => Icons.error_rounded,
      MediaStatus.queued => Icons.hourglass_top_rounded,
    };
  }
}
