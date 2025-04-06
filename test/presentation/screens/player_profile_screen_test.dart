import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/presentation/screens/player_profile_screen.dart';
import 'package:joola_spot/presentation/widgets/game_history_list.dart';

void main() {
  late Player mockPlayer;
  late PlayerProfile mockPlayerProfile;

  setUp(() {
    mockPlayer = Player(
      id: '1',
      name: 'John Doe',
      privacy: PlayerPrivacy.public,
      ratings: [
        Rating(
          id: '1',
          category: 'skill',
          score: 4.5,
          date: DateTime.now(),
          ratedBy: '2',
        )
      ],
      badges: [],
      friendIds: [],
      blockedIds: [],
      joinedAt: DateTime.now(),
      isActive: true,
    );

    mockPlayerProfile = PlayerProfile(
      id: mockPlayer.id,
      name: mockPlayer.name,
      rating: mockPlayer.averageRating,
      gamesPlayed: mockPlayer.ratings.length,
      profilePicUrl: mockPlayer.photoUrl,
    );
  });

  testWidgets('PlayerProfileScreen displays basic info', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Rating: 4.5'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen displays ratings', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.text('Skill Rating'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen displays badges', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.text('Badges'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen handles private profile', (tester) async {
    final privatePlayer = mockPlayer.copyWith(privacy: PlayerPrivacy.anonymous);
    final privatePlayerProfile = PlayerProfile(
      id: privatePlayer.id,
      name: privatePlayer.name,
      rating: privatePlayer.averageRating,
      gamesPlayed: privatePlayer.ratings.length,
      profilePicUrl: privatePlayer.photoUrl,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: privatePlayerProfile),
      ),
    );

    expect(find.text('Private Profile'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen displays friend list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.text('Friends'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen displays game history', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.text('Game History'), findsOneWidget);
  });

  testWidgets('PlayerProfileScreen shows game history list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PlayerProfileScreen(player: mockPlayerProfile),
      ),
    );

    expect(find.byType(GameHistoryList), findsOneWidget);
  });
}
