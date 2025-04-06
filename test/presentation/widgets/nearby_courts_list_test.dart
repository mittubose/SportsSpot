import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/presentation/widgets/nearby_courts_list.dart';

void main() {
  testWidgets('NearbyCourtsList shows courts', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: NearbyCourtsList(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that courts are displayed
    expect(find.byType(Card), findsWidgets);
    expect(find.text('DLF Sports Complex'), findsOneWidget);
    expect(find.text('Siri Fort Sports Complex'), findsOneWidget);
  });
}
