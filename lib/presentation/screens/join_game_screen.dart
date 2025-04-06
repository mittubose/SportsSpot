import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/chat.dart';
import 'package:joola_spot/presentation/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class JoinGameScreen extends ConsumerWidget {
  final PublicGame game;

  const JoinGameScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                      'Game Type',
                      game.gameType == GameType.casual
                          ? 'Casual'
                          : 'Competitive'),
                  _buildInfoRow(
                      'Skill Level',
                      game.skillLevel == SkillLevel.intermediate
                          ? 'Intermediate'
                          : 'Advanced'),
                  _buildInfoRow('Price', '\$${game.pricePerPlayer}'),
                  _buildInfoRow('Time',
                      '${DateFormat('h:mm a').format(game.startTime)} - ${DateFormat('h:mm a').format(game.endTime)}'),
                  const SizedBox(height: 24),
                  _buildPlayerSlots(),
                  const SizedBox(height: 24),
                  _buildGameRequirements(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => _showJoinConfirmation(context),
                    child: const Text('Join Game'),
                  ),
                ],
              ),
            ),
          ),
          _buildChatSection(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSlots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Player Slots (${game.currentPlayers}/${game.maxPlayers})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: game.maxPlayers,
            itemBuilder: (context, index) {
              bool isOccupied = index < game.currentPlayers;
              PlayerProfile? profile =
                  isOccupied && index < game.playerProfiles.length
                      ? game.playerProfiles[index]
                      : null;

              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    GestureDetector(
                      key: profile != null
                          ? Key('player_profile_${profile.id}')
                          : null,
                      onTap: profile != null
                          ? () => _showPlayerProfile(context, profile)
                          : null,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isOccupied ? Colors.green : Colors.grey[300],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isOccupied
                                ? Colors.green.shade700
                                : Colors.grey.shade400,
                            width: 2,
                          ),
                          image: profile?.profilePicUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(profile!.profilePicUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: profile?.profilePicUrl == null
                            ? Icon(
                                Icons.person,
                                color: isOccupied
                                    ? Colors.white
                                    : Colors.grey[600],
                                size: 32,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile?.name ?? 'Available',
                      key: profile != null
                          ? Key('player_name_${profile.id}')
                          : null,
                      style: TextStyle(
                        fontSize: 12,
                        color: isOccupied ? Colors.black87 : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showPlayerProfile(BuildContext context, PlayerProfile profile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Player Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Rating: ${profile.rating}'),
            Text('Games Played: ${profile.gamesPlayed}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showJoinConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Game'),
        content: Text('Are you sure you want to join ${game.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle join game logic
              Navigator.pop(context);
            },
            child: const Text('Join Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildGameRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Game Requirements',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: game.requirements.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(game.requirements[index]),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatSection() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  'Game Chat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: game.chatMessages.length,
              itemBuilder: (context, index) {
                final message = game.chatMessages[index];
                final sender = game.playerProfiles.firstWhere(
                  (p) => p.id == message.senderId,
                  orElse: () => PlayerProfile(
                    id: message.senderId,
                    name: 'Unknown',
                    rating: 0,
                    gamesPlayed: 0,
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: sender.profilePicUrl != null
                            ? NetworkImage(sender.profilePicUrl!)
                            : null,
                        child: sender.profilePicUrl == null
                            ? const Icon(Icons.person,
                                size: 20, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sender.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(message.message),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // TODO: Implement send message
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
