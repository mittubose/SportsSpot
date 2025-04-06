import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/venue.dart';

class MatchDiscoveryScreen extends ConsumerStatefulWidget {
  const MatchDiscoveryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MatchDiscoveryScreen> createState() =>
      _MatchDiscoveryScreenState();
}

class _MatchDiscoveryScreenState extends ConsumerState<MatchDiscoveryScreen> {
  GameType? _selectedGameType;
  SkillLevel? _selectedSkillLevel;
  bool _showingVibeCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Discovery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              setState(() {
                // Show nearby matches
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showingVibeCheck = false;
                    });
                  },
                  child: const Text('Recommended Matches'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showingVibeCheck = true;
                    });
                  },
                  child: const Text('Vibe Check'),
                ),
              ],
            ),
          ),
          if (!_showingVibeCheck) ...[
            _buildFilterSection(),
            _buildMatchList(),
          ] else ...[
            _buildVibeCheckSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          DropdownButton<GameType>(
            value: _selectedGameType,
            hint: const Text('Game Type'),
            items: GameType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGameType = value;
              });
            },
          ),
          const SizedBox(width: 16),
          DropdownButton<SkillLevel>(
            value: _selectedSkillLevel,
            hint: const Text('Skill Level'),
            items: SkillLevel.values.map((level) {
              return DropdownMenuItem(
                value: level,
                child: Text(level.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSkillLevel = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMatchList() {
    // TODO: Replace with actual data from provider
    final games = [
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
        playerProfiles: [],
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
        playerProfiles: [],
        chatMessages: [],
      ),
    ];

    final filteredGames = games.where((game) {
      if (_selectedGameType != null && game.gameType != _selectedGameType) {
        return false;
      }
      if (_selectedSkillLevel != null &&
          game.skillLevel != _selectedSkillLevel) {
        return false;
      }
      return true;
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredGames.length,
        itemBuilder: (context, index) {
          final game = filteredGames[index];
          return ListTile(
            title: Text(game.title),
            subtitle: Text('${game.currentPlayers}/${game.maxPlayers} players'),
            trailing: Text('\$${game.pricePerPlayer} per player'),
            onTap: () => _showMatchDetails(game),
          );
        },
      ),
    );
  }

  Widget _buildVibeCheckSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Players with Similar Interests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Similar Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Nearby Players',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showMatchDetails(PublicGame game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Match Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Test Venue'),
            Text('Players (${game.currentPlayers}/${game.maxPlayers})'),
            Text('John Doe'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showJoinConfirmation(game),
              child: const Text('Join Match'),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinConfirmation(PublicGame game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Join'),
        content: Text('\$${game.pricePerPlayer} per player'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _joinMatch(game);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _joinMatch(PublicGame game) {
    // TODO: Implement actual join logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully joined the match!')),
    );
  }
}
