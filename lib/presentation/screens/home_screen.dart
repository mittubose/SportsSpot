import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/presentation/widgets/upcoming_games_list.dart';
import 'package:joola_spot/presentation/widgets/nearby_courts_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joola Spot'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement create game
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text(
              'Upcoming Games',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            UpcomingGamesList(),
            SizedBox(height: 24),
            Text(
              'Nearby Courts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            NearbyCourtsList(),
          ],
        ),
      ),
    );
  }
}
