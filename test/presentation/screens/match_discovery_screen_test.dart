import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/presentation/screens/match_discovery_screen.dart';

void main() {
  late List<PublicGame> mockGames;
  late List<PlayerProfile> mockPlayers;
  late Venue mockVenue;

  setUp(() {
    mockPlayers = [
      PlayerProfile(
        id: 'player1',
        name: 'John Doe',
        rating: 4.5,
        gamesPlayed: 20,
        profilePicUrl: 'https://example.com/pic1.jpg',
      ),
      PlayerProfile(
        id: 'player2',
        name: 'Jane Smith',
        rating: 4.2,
        gamesPlayed: 15,
        profilePicUrl: 'https://example.com/pic2.jpg',
      ),
    ];

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
      timeSlots: [],
      currentBookings: [],
      publicGameIds: [],
      rating: 4.5,
      totalRatings: 10,
      isActive: true,
      createdAt: DateTime.now(),
    );

    mockGames = [
      PublicGame(
        id: 'game1',
        title: 'Casual Match',
        startTime: DateTime.now().add(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
        maxPlayers: 4,
        currentPlayers: 2,
        gameType: GameType.casual,
        skillLevel: SkillLevel.intermediate,
        pricePerPlayer: 20.0,
        requirements: ['Bring your own racket'],
        playerIds: ['player1', 'player2'],
        courtId: '1',
        playerProfiles: mockPlayers,
        chatMessages: [],
      ),
      PublicGame(
        id: 'game2',
        title: 'Pro Match',
        startTime: DateTime.now().add(const Duration(days: 2)),
        endTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
        maxPlayers: 4,
        currentPlayers: 1,
        gameType: GameType.pro,
        skillLevel: SkillLevel.pro,
        pricePerPlayer: 30.0,
        requirements: ['Pro level players only'],
        playerIds: ['player1'],
        courtId: '1',
        playerProfiles: [mockPlayers[0]],
        chatMessages: [],
      ),
    ];
  });

  testWidgets('MatchDiscoveryScreen displays recommended matches',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    expect(find.text('Recommended Matches'), findsOneWidget);
    expect(find.text('Casual Match'), findsOneWidget);
    expect(find.text('Pro Match'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen filters matches by type', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    // Test filter by game type
    await tester.tap(find.byKey(const Key('filter_type_casual')));
    await tester.pumpAndSettle();

    expect(find.text('Casual Match'), findsOneWidget);
    expect(find.text('Pro Match'), findsNothing);

    await tester.tap(find.byKey(const Key('filter_type_pro')));
    await tester.pumpAndSettle();

    expect(find.text('Casual Match'), findsNothing);
    expect(find.text('Pro Match'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen filters matches by skill level',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    // Test filter by skill level
    await tester.tap(find.byKey(const Key('filter_skill_intermediate')));
    await tester.pumpAndSettle();

    expect(find.text('Casual Match'), findsOneWidget);
    expect(find.text('Pro Match'), findsNothing);

    await tester.tap(find.byKey(const Key('filter_skill_pro')));
    await tester.pumpAndSettle();

    expect(find.text('Casual Match'), findsNothing);
    expect(find.text('Pro Match'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen shows match details', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Casual Match'));
    await tester.pumpAndSettle();

    expect(find.text('Match Details'), findsOneWidget);
    expect(find.text('Test Venue'), findsOneWidget);
    expect(find.text('Players (2/4)'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen handles location-based search',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('location_filter')));
    await tester.pumpAndSettle();

    expect(find.text('Matches Near You'), findsOneWidget);
    expect(find.text('Test Venue'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen shows vibe check recommendations',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Vibe Check'));
    await tester.pumpAndSettle();

    expect(find.text('Players with Similar Interests'), findsOneWidget);
    expect(find.text('Similar Schedule'), findsOneWidget);
    expect(find.text('Nearby Players'), findsOneWidget);
  });

  testWidgets('MatchDiscoveryScreen handles match joining', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MatchDiscoveryScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Casual Match'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Match'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm Join'), findsOneWidget);
    expect(find.text('Price per player: \$20.0'), findsOneWidget);

    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    expect(find.text('Successfully joined the match!'), findsOneWidget);
  });
}
