import 'package:flutter_test/flutter_test.dart';
import 'package:memoryvault/main.dart';

void main() {
  testWidgets('MemoryVault app opens to Photos', (tester) async {
    await tester.pumpWidget(const MemoryVaultApp());
    await tester.pumpAndSettle();

    expect(find.text('MemoryVault'), findsOneWidget);
    expect(find.text('Photos'), findsWidgets);
    expect(find.text('Memories'), findsOneWidget);
    expect(find.text('Shared'), findsOneWidget);
    expect(find.text('Backup'), findsOneWidget);
  });
}
