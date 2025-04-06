import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/presentation/widgets/game_history_list.dart';

class PlayerProfileScreen extends ConsumerStatefulWidget {
  final PlayerProfile player;

  const PlayerProfileScreen({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  ConsumerState<PlayerProfileScreen> createState() =>
      _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends ConsumerState<PlayerProfileScreen> {
  bool _isProfileVisible = true;
  bool _isGameHistoryVisible = true;
  bool _isRatingVisible = true;
  bool _isFriendRequestSent = false;
  bool _isBlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileInfo(),
            const SizedBox(height: 16),
            _buildRatings(),
            const SizedBox(height: 16),
            _buildBadges(),
            const SizedBox(height: 16),
            _buildFriendsList(),
            const SizedBox(height: 16),
            _buildPrivacySettings(),
            const SizedBox(height: 16),
            _buildFriendActions(),
            const SizedBox(height: 16),
            _buildGameHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.player.profilePicUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.player.profilePicUrl!),
          ),
        const SizedBox(height: 16),
        Text('Rating: ${widget.player.rating}'),
        Text('Games Played: ${widget.player.gamesPlayed}'),
      ],
    );
  }

  Widget _buildRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skill Rating',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('${widget.player.rating}'),
      ],
    );
  }

  Widget _buildBadges() {
    // TODO: Replace with actual badges from provider
    final badges = [
      Badge(
        id: 'badge1',
        name: 'Regular Player',
        description: 'Played 10+ games',
        icon: 'regular_player.png',
      ),
      Badge(
        id: 'badge2',
        name: 'Pro Player',
        description: 'Maintained 4.5+ rating',
        icon: 'pro_player.png',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Badges',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: badges.map((badge) => _buildBadge(badge)).toList(),
        ),
      ],
    );
  }

  Widget _buildBadge(Badge badge) {
    return Tooltip(
      message: badge.description,
      child: Chip(
        label: Text(badge.name),
        avatar: Icon(Icons.star),
      ),
    );
  }

  Widget _buildFriendsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Friends',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // TODO: Add friends list implementation
        const Text('No friends yet'),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Private Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Profile Visibility'),
          value: _isProfileVisible,
          onChanged: (value) {
            setState(() {
              _isProfileVisible = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Game History Visibility'),
          value: _isGameHistoryVisible,
          onChanged: (value) {
            setState(() {
              _isGameHistoryVisible = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Rating Visibility'),
          value: _isRatingVisible,
          onChanged: (value) {
            setState(() {
              _isRatingVisible = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFriendActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isFriendRequestSent = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Friend Request Sent')),
            );
          },
          child:
              Text(_isFriendRequestSent ? 'Friend Request Sent' : 'Add Friend'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            setState(() {
              _isBlocked = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Player Blocked')),
            );
          },
          child: Text(_isBlocked ? 'Player Blocked' : 'Block Player'),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
        ),
      ],
    );
  }

  Widget _buildGameHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Game History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // TODO: Replace with actual game history from provider
        GameHistoryList(games: []),
      ],
    );
  }
}
