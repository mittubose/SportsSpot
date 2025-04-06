import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/presentation/screens/create_game_screen.dart';
import 'package:joola_spot/presentation/widgets/time_slot_selector.dart';

void main() {
  late PlayerProfile mockPlayer;
  late Venue mockVenue;

  setUp(() {
    mockPlayer = PlayerProfile(
      id: 'player1',
      name: 'John Doe',
      rating: 4.5,
      gamesPlayed: 20,
      profilePicUrl: 'https://example.com/pic1.jpg',
    );

    mockVenue = Venue(
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
      timeSlots: [
        TimeSlot(
          id: '1',
          startTime: DateTime.now().add(const Duration(hours: 1)),
          endTime: DateTime.now().add(const Duration(hours: 2)),
          price: 500,
          isAvailable: true,
        )
      ],
      currentBookings: [],
      publicGameIds: [],
      rating: 4.5,
      totalRatings: 10,
      isActive: true,
      createdAt: DateTime.now(),
    );
  });

  testWidgets('CreateGameScreen basic form validation', (tester) async {
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
    await tester.enterText(find.byType(TextFormField).first, 'Test Game');
    await tester.pump();

    // Fill in description
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Test Description');
    await tester.pump();

    // Test player count selection
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('4').last);
    await tester.pumpAndSettle();

    // Test game privacy selection
    await tester.tap(find.byType(DropdownButtonFormField<GamePrivacy>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Public').last);
    await tester.pumpAndSettle();

    // Test game type selection
    await tester.tap(find.byType(DropdownButtonFormField<GameType>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Casual').last);
    await tester.pumpAndSettle();

    // Test skill level selection
    await tester.tap(find.byType(DropdownButtonFormField<SkillLevel>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Intermediate').last);
    await tester.pumpAndSettle();

    // Verify form is now valid
    expect(tester.widget<ElevatedButton>(createButton).onPressed, isNotNull);
  });

  testWidgets('CreateGameScreen handles game requirements selection',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CreateGameScreen(),
        ),
      ),
    );

    // Open requirements section
    await tester.tap(find.text('Game Requirements'));
    await tester.pumpAndSettle();

    // Test common requirements
    expect(find.text('Bring your own bat'), findsOneWidget);
    expect(find.text('Women only'), findsOneWidget);
    expect(find.text('Men only'), findsOneWidget);
    expect(find.text('Pro match'), findsOneWidget);

    // Select requirements
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();

    // Verify selection
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, true);
  });

  testWidgets('CreateGameScreen player search and invitation', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CreateGameScreen(),
        ),
      ),
    );

    // Open player selection
    await tester.tap(find.text('Add Players'));
    await tester.pumpAndSettle();

    // Test search functionality
    await tester.enterText(find.byType(TextField), 'John');
    await tester.pump();

    // Verify search results
    expect(find.text('John Doe'), findsOneWidget);

    // Test player selection
    await tester.tap(find.text('John Doe'));
    await tester.pumpAndSettle();

    // Verify selected player
    expect(find.text('Selected Players (1)'), findsOneWidget);
  });

  testWidgets('CreateGameScreen venue and time slot selection', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CreateGameScreen(),
        ),
      ),
    );

    // Open venue selection
    await tester.tap(find.text('Select Venue'));
    await tester.pumpAndSettle();

    // Test venue search
    await tester.enterText(find.byType(TextField), 'Test Venue');
    await tester.pump();

    // Select venue
    await tester.tap(find.text('Test Venue'));
    await tester.pumpAndSettle();

    // Verify venue selection
    expect(find.text('Test Venue'), findsOneWidget);

    // Test time slot selection
    expect(find.text('Available Time Slots'), findsOneWidget);
    await tester.tap(find.byType(TimeSlotSelector));
    await tester.pumpAndSettle();

    // Verify time slot selection
    expect(find.text('Selected: 1:00 PM - 2:00 PM'), findsOneWidget);
  });
}
