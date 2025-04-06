import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingGamesList extends ConsumerWidget {
  const UpcomingGamesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Get games from provider
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3, // TODO: Get actual count
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: const Text('Friendly Match'),
            subtitle: const Text('Central Park Courts • Today, 2:00 PM'),
            trailing: const Chip(
              label: Text('2 spots'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // TODO: Navigate to game details
            },
          );
        },
      ),
    );
  }
}
