import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/presentation/screens/create_game_screen.dart';
import 'package:joola_spot/presentation/screens/venue_selection_screen.dart';

void main() {
  testWidgets('CreateGameScreen form validation', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CreateGameScreen(),
        ),
      ),
    );

    // Initial validation
    final createButton = find.byType(ElevatedButton);
    expect(createButton, findsOneWidget);
    expect(tester.widget<ElevatedButton>(createButton).onPressed, isNull);

    // Fill in title
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Game Title'), 'Test Game');
    await tester.pumpAndSettle();

    // Test dropdowns
    await tester.tap(find.byType(DropdownButtonFormField<GamePrivacy>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(GamePrivacy.private.name).last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<GameType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(GameType.pro.name).last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<SkillLevel>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(SkillLevel.pro.name).last);
    await tester.pumpAndSettle();

    // Test venue selection
    await tester.tap(find.widgetWithText(ListTile, 'Select Venue'));
    await tester.pumpAndSettle();

    // Verify venue selection screen
    expect(find.text('Select Venue'), findsOneWidget);
  });

  testWidgets('CreateGameScreen venue and time slot selection', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CreateGameScreen(),
        ),
      ),
    );

    // Test venue selection
    await tester.tap(find.widgetWithText(ListTile, 'Select Venue'));
    await tester.pumpAndSettle();

    // Verify venue selection screen
    expect(find.text('Select Venue'), findsOneWidget);

    // Mock venue selection
    final mockVenue = Venue(
      id: '1',
      name: 'Test Venue',
      address: 'Test Address',
      latitude: 0,
      longitude: 0,
      description: 'Test venue description',
      amenities: ['Test'],
      images: ['test.jpg'],
      courtTypes: ['singles'],
      registeredPlayers: [],
      chatMessages: [],
      timeSlots: [],
      currentBookings: [],
      publicGameIds: [],
      rating: 4.5,
      totalRatings: 10,
      isActive: true,
      createdAt: DateTime.now(),
    );

    // Navigate back with selected venue
    Navigator.of(tester.element(find.byType(Scaffold))).pop(mockVenue);
    await tester.pumpAndSettle();

    // Verify venue is selected
    expect(find.text('Test Venue'), findsOneWidget);

    // Verify time slots are displayed
    expect(find.text('Available Time Slots'), findsOneWidget);
  });
}
