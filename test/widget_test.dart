import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memoryvault/models/media_status.dart';
import 'package:memoryvault/widgets/status_badges.dart';

void main() {
  testWidgets('status badges expose local-first storage states',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatusBadges(
            statuses: {
              MediaStatus.local,
              MediaStatus.backedUp,
              MediaStatus.shared,
              MediaStatus.queued,
            },
          ),
        ),
      ),
    );

    expect(find.byTooltip('Local'), findsOneWidget);
    expect(find.byTooltip('Backed up'), findsOneWidget);
    expect(find.byTooltip('Shared'), findsOneWidget);
    expect(find.byTooltip('Queued'), findsOneWidget);
  });
}
