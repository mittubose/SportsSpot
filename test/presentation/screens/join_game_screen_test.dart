import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/chat.dart';
import 'package:joola_spot/presentation/screens/join_game_screen.dart';

void main() {
  late PublicGame mockGame;

  setUp(() {
    mockGame = PublicGame(
      id: 'test-game-1',
      title: 'Test Game',
      startTime: DateTime(2024, 3, 1, 10, 0),
      endTime: DateTime(2024, 3, 1, 11, 0),
      maxPlayers: 4,
      currentPlayers: 2,
      gameType: GameType.casual,
      skillLevel: SkillLevel.intermediate,
      pricePerPlayer: 20.0,
      requirements: ['Bring your own racket', 'Wear proper shoes'],
      playerIds: ['player-1', 'player-2'],
      courtId: 'court-1',
      playerProfiles: [
        PlayerProfile(
          id: 'player-1',
          name: 'John Doe',
          rating: 4.5,
          gamesPlayed: 20,
          profilePicUrl: 'https://example.com/pic1.jpg',
        ),
        PlayerProfile(
          id: 'player-2',
          name: 'Jane Smith',
          rating: 4.2,
          gamesPlayed: 15,
          profilePicUrl: 'https://example.com/pic2.jpg',
        ),
      ],
      chatMessages: [
        ChatMessage(
          id: '1',
          senderId: '1',
          message: 'Hello everyone!',
          timestamp: DateTime.now(),
        ),
      ],
    );
  });

  testWidgets('JoinGameScreen displays game details correctly', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: JoinGameScreen(game: mockGame),
        ),
      ),
    );

    expect(find.text('Test Game'), findsOneWidget);
    expect(find.text('Game Type: Casual'), findsOneWidget);
    expect(find.text('Skill Level: Intermediate'), findsOneWidget);
    expect(find.text('Price: \$20.0'), findsOneWidget);
  });

  testWidgets('JoinGameScreen displays player slots correctly', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: JoinGameScreen(game: mockGame),
        ),
      ),
    );

    expect(find.text('Player Slots (2/4)'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Available'), findsNWidgets(2));
  });

  testWidgets('JoinGameScreen shows player profile on tap', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: JoinGameScreen(game: mockGame),
        ),
      ),
    );

    await tester.tap(
        find.byKey(Key('player_profile_${mockGame.playerProfiles[0].id}')));
    await tester.pumpAndSettle();

    expect(find.text('Player Details'), findsOneWidget);
    expect(find.text('Rating: 4.5'), findsOneWidget);
    expect(find.text('Games Played: 20'), findsOneWidget);
  });

  testWidgets('JoinGameScreen shows chat section', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: JoinGameScreen(game: mockGame),
        ),
      ),
    );

    expect(find.text('Game Chat'), findsOneWidget);
    expect(find.text('Hello everyone!'), findsOneWidget);
  });

  testWidgets('JoinGameScreen shows join confirmation dialog', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: JoinGameScreen(game: mockGame),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Join Game'), findsNWidgets(2));
    expect(
        find.text('Are you sure you want to join Test Game?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });
}
