// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:joola_spot/main.dart';

void main() {
  testWidgets('Main app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that the app starts with the dashboard
    expect(find.text('Joola Spot'), findsOneWidget);
    expect(find.text('Find Courts Near You'), findsOneWidget);
    expect(find.text('Nearby Courts'), findsOneWidget);

    // Test bottom navigation
    await tester.tap(find.text('Courts'));
    await tester.pumpAndSettle();
    expect(find.text('Map View Coming Soon!'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('John Doe'), findsOneWidget);
  });
}
