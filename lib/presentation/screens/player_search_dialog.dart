import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/player.dart';

class PlayerSearchDialog extends ConsumerStatefulWidget {
  final Function(PlayerProfile) onPlayerSelected;

  const PlayerSearchDialog({
    super.key,
    required this.onPlayerSelected,
  });

  @override
  ConsumerState<PlayerSearchDialog> createState() => _PlayerSearchDialogState();
}

class _PlayerSearchDialogState extends ConsumerState<PlayerSearchDialog> {
  final _searchController = TextEditingController();
  List<PlayerProfile> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = [
      PlayerProfile(
        id: 'player1',
        name: 'John Doe',
        rating: 4.5,
        gamesPlayed: 20,
        profilePicUrl: 'https://example.com/pic1.jpg',
      ),
      PlayerProfile(
        id: 'player2',
        name: 'Jane Smith',
        rating: 4.0,
        gamesPlayed: 15,
        profilePicUrl: 'https://example.com/pic2.jpg',
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _searchResults = _searchResults
          .where((player) =>
              player.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Players',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearch,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final player = _searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(player.profilePicUrl ?? ''),
                    ),
                    title: Text(player.name ?? ''),
                    subtitle: Text('Rating: ${player.rating}'),
                    onTap: () {
                      widget.onPlayerSelected(player);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
