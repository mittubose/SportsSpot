import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/player.dart';

class PlayerProfileScreen extends ConsumerWidget {
  final Player player;

  const PlayerProfileScreen({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // TODO: Navigate to chat with player
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          _buildRatings(context),
          const SizedBox(height: 24),
          _buildBadges(context),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement add/remove friend functionality
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Friend'),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.block),
                onPressed: () {
                  // TODO: Implement block functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              player.photoUrl != null ? NetworkImage(player.photoUrl!) : null,
          child: player.photoUrl == null
              ? Text(
                  player.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                )
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          player.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              player.averageRating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 16),
            const Icon(Icons.calendar_today),
            const SizedBox(width: 4),
            Text(
              'Joined ${_formatDate(player.joinedAt)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatings(BuildContext context) {
    final ratingCategories = _groupRatingsByCategory();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ratings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...ratingCategories.entries.map((entry) {
          final category = entry.key;
          final ratings = entry.value;
          final averageRating =
              ratings.map((r) => r.score).reduce((a, b) => a + b) /
                  ratings.length;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: averageRating / 5,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBadges(BuildContext context) {
    if (player.badges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badges',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: player.badges.map((badge) {
            return Tooltip(
              message: badge.description,
              child: Chip(
                avatar: const Icon(Icons.military_tech),
                label: Text(badge.name),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Map<String, List<Rating>> _groupRatingsByCategory() {
    final groupedRatings = <String, List<Rating>>{};
    for (final rating in player.ratings) {
      groupedRatings.putIfAbsent(rating.category, () => []).add(rating);
    }
    return groupedRatings;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
