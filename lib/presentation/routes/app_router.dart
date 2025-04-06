import 'package:flutter/material.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/presentation/screens/main_screen.dart';
import 'package:joola_spot/presentation/screens/create_game_screen.dart';
import 'package:joola_spot/presentation/screens/game_details_screen.dart';
import 'package:joola_spot/presentation/screens/player_profile_screen.dart';
import 'package:joola_spot/presentation/screens/venue_details_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String createGame = '/create-game';
  static const String gameDetails = '/game-details';
  static const String playerProfile = '/player-profile';
  static const String venueDetails = '/venue-details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case createGame:
        return MaterialPageRoute(
          builder: (_) => const CreateGameScreen(),
        );
      case gameDetails:
        final game = settings.arguments as Game;
        return MaterialPageRoute(
          builder: (_) => GameDetailsScreen(game: game),
        );
      case playerProfile:
        final player = settings.arguments as PlayerProfile;
        return MaterialPageRoute(
          builder: (context) => PlayerProfileScreen(player: player),
        );
      case venueDetails:
        final venue = settings.arguments as Venue;
        return MaterialPageRoute(
          builder: (_) => VenueDetailsScreen(venue: venue),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void navigateToCreateGame(BuildContext context) {
    Navigator.pushNamed(context, createGame);
  }

  static void navigateToGameDetails(BuildContext context, Game game) {
    Navigator.pushNamed(
      context,
      gameDetails,
      arguments: game,
    );
  }

  static void navigateToPlayerProfile(
      BuildContext context, PlayerProfile player) {
    Navigator.pushNamed(
      context,
      playerProfile,
      arguments: player,
    );
  }

  static void navigateToVenueDetails(BuildContext context, Venue venue) {
    Navigator.pushNamed(
      context,
      venueDetails,
      arguments: venue,
    );
  }
}
