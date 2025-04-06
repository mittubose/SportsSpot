import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/presentation/screens/court_details_screen.dart';

class FavoriteCourtScreen extends ConsumerWidget {
  const FavoriteCourtScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Courts'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFavoriteCard(
            context,
            Court(
              id: '1',
              name: 'DLF Sports Complex',
              latitude: 12.9716,
              longitude: 77.5946,
              address: 'DLF Phase 1, Gurgaon, Haryana',
              rating: 4.5,
              isJoolaVerified: true,
              numberOfCourts: 4,
              photoUrl: null,
              distance: 2.5,
              amenities: ['Parking', 'Changing Rooms', 'Cafeteria'],
              openingHours: '6:00 AM - 10:00 PM',
              pricePerHour: 800,
            ),
          ),
          _buildFavoriteCard(
            context,
            Court(
              id: '2',
              name: 'Siri Fort Sports Complex',
              latitude: 28.5529,
              longitude: 77.2167,
              address: 'August Kranti Marg, New Delhi',
              rating: 4.8,
              isJoolaVerified: true,
              numberOfCourts: 6,
              photoUrl: null,
              distance: 3.2,
              amenities: ['Parking', 'Pro Shop', 'Coaching'],
              openingHours: '5:00 AM - 9:00 PM',
              pricePerHour: 600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Court court) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourtDetailsScreen(court: court),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.sports_tennis,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          court.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          // TODO: Implement unfavorite
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(court.rating.toString()),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text('${court.distance?.toStringAsFixed(1)} km'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${court.pricePerHour}/hour',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
