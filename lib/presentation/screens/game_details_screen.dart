import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/presentation/routes/app_router.dart';

class GameDetailsScreen extends ConsumerWidget {
  final Game game;

  const GameDetailsScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGameInfo(context),
          const SizedBox(height: 16),
          _buildVenueInfo(context),
          const SizedBox(height: 16),
          _buildPlayersList(context),
          const SizedBox(height: 16),
          _buildRequirements(context),
          const SizedBox(height: 16),
          if (game.description.isNotEmpty) ...[
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(game.description),
            const SizedBox(height: 16),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement join game functionality
                  },
                  child: const Text('Join Game'),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  // TODO: Navigate to game chat
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  '${game.dateTime.day}/${game.dateTime.month}/${game.dateTime.year}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text(
                  '${game.dateTime.hour}:${game.dateTime.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(
                  label: Text(game.gameType.name),
                  avatar: const Icon(Icons.sports),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(game.skillLevel.name),
                  avatar: const Icon(Icons.grade),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('${game.playerCount} players'),
                  avatar: const Icon(Icons.people),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueInfo(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(game.venue.name),
        subtitle: Text(game.venue.address),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => AppRouter.navigateToVenueDetails(context, game.venue),
      ),
    );
  }

  Widget _buildPlayersList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Players (${game.players.length}/${game.playerCount})',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: game.players.length,
          itemBuilder: (context, index) {
            final player = game.players[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: player.photoUrl != null
                    ? NetworkImage(player.photoUrl!)
                    : null,
                child: player.photoUrl == null
                    ? Text(player.name[0].toUpperCase())
                    : null,
              ),
              title: Text(player.name),
              subtitle: Row(
                children: [
                  const Icon(Icons.star, size: 16),
                  const SizedBox(width: 4),
                  Text(player.averageRating.toStringAsFixed(1)),
                ],
              ),
              onTap: () {
                final playerProfile = PlayerProfile(
                  id: player.id,
                  name: player.name,
                  rating: player.averageRating,
                  gamesPlayed: player.ratings.length,
                  profilePicUrl: player.photoUrl,
                );
                AppRouter.navigateToPlayerProfile(context, playerProfile);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildRequirements(BuildContext context) {
    if (game.requirements.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requirements',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: game.requirements.map((req) {
            return Chip(
              label: Text(req),
              avatar: const Icon(Icons.check_circle),
            );
          }).toList(),
        ),
      ],
    );
  }
}
