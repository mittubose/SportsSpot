import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';

class PublicGamesScreen extends ConsumerWidget {
  const PublicGamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courtsAsync = ref.watch(nearbyCourtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Games'),
      ),
      body: courtsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (courts) {
          final allGames = courts
              .expand((court) =>
                  court.publicGames.map((game) => (court: court, game: game)))
              .toList();

          if (allGames.isEmpty) {
            return const Center(
              child: Text('No public games available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allGames.length,
            itemBuilder: (context, index) {
              final game = allGames[index].game;
              final court = allGames[index].court;
              return _buildGameCard(context, game, court);
            },
          );
        },
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, PublicGame game, Court court) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(game.title),
            subtitle: Text(court.name),
            trailing: Text(
              '₹${game.pricePerPlayer}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${DateFormat('h:mm a').format(game.startTime)} - ${DateFormat('h:mm a').format(game.endTime)}',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text('${game.currentPlayers}/${game.maxPlayers} players'),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.sports_tennis,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(game.gameType),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(game.skillLevel),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: game.currentPlayers < game.maxPlayers
                      ? () {
                          // TODO: Implement join game
                        }
                      : null,
                  child: Text(
                    game.currentPlayers < game.maxPlayers
                        ? 'Join Game'
                        : 'Game Full',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
