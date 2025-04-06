import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/presentation/routes/app_router.dart';
import 'package:joola_spot/presentation/screens/court_map_screen.dart';
import 'package:joola_spot/presentation/screens/create_game_screen.dart';
import 'package:joola_spot/presentation/screens/game_details_screen.dart';
import 'package:joola_spot/presentation/screens/player_profile_screen.dart';
import 'package:joola_spot/presentation/screens/venue_details_screen.dart';

void main() {
  testWidgets('Initial route shows CourtMapScreen', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CourtMapScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CourtMapScreen), findsOneWidget);
  });

  testWidgets('Navigate to CreateGameScreen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: {
            '/create-game': (context) => const CreateGameScreen(),
          },
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => AppRouter.navigateToCreateGame(context),
              child: const Text('Navigate'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    expect(find.byType(CreateGameScreen), findsOneWidget);
  });

  testWidgets('Navigate to GameDetailsScreen', (tester) async {
    final mockGame = Game(
      id: '1',
      title: 'Test Game',
      dateTime: DateTime.now(),
      playerCount: 4,
      privacy: GamePrivacy.public,
      gameType: GameType.casual,
      skillLevel: SkillLevel.beginner,
      venue: Venue(
        id: '1',
        name: 'Test Venue',
        address: 'Test Address',
        latitude: 0,
        longitude: 0,
        amenities: ['Test'],
        timeSlots: [],
        currentBookings: [],
        publicGameIds: [],
        rating: 4.5,
        totalRatings: 10,
        isActive: true,
        createdAt: DateTime.now(),
      ),
      players: [],
      requirements: [],
      description: 'Test Description',
      isActive: true,
      createdAt: DateTime.now(),
      createdBy: 'Test User',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: {
            '/game-details': (context) => GameDetailsScreen(game: mockGame),
          },
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () =>
                  AppRouter.navigateToGameDetails(context, mockGame),
              child: const Text('Navigate'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    expect(find.byType(GameDetailsScreen), findsOneWidget);
  });

  testWidgets('Navigate to PlayerProfileScreen', (tester) async {
    final mockPlayer = Player(
      id: '1',
      name: 'Test Player',
      privacy: PlayerPrivacy.public,
      ratings: [],
      badges: [],
      friendIds: [],
      blockedIds: [],
      joinedAt: DateTime.now(),
      isActive: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: {
            '/player-profile': (context) =>
                PlayerProfileScreen(player: mockPlayer),
          },
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () =>
                  AppRouter.navigateToPlayerProfile(context, mockPlayer),
              child: const Text('Navigate'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    expect(find.byType(PlayerProfileScreen), findsOneWidget);
  });

  testWidgets('Navigate to VenueDetailsScreen', (tester) async {
    final mockVenue = Venue(
      id: '1',
      name: 'Test Venue',
      address: 'Test Address',
      latitude: 0,
      longitude: 0,
      amenities: ['Test'],
      timeSlots: [],
      currentBookings: [],
      publicGameIds: [],
      rating: 4.5,
      totalRatings: 10,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: {
            '/venue-details': (context) => VenueDetailsScreen(venue: mockVenue),
          },
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () =>
                  AppRouter.navigateToVenueDetails(context, mockVenue),
              child: const Text('Navigate'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    expect(find.byType(VenueDetailsScreen), findsOneWidget);
  });
}
