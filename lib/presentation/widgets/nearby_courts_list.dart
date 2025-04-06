import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/screens/court_details_screen.dart';

class NearbyCourtsList extends ConsumerWidget {
  const NearbyCourtsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courtsAsync = ref.watch(nearbyCourtsProvider);

    return courtsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (courts) => Card(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: courts.length,
          itemBuilder: (context, index) {
            final court = courts[index];
            return ListTile(
              leading: const Icon(Icons.sports_tennis),
              title: Text(court.name),
              subtitle: Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber[700]),
                  Text(
                      ' ${court.rating} • ${court.distance?.toStringAsFixed(1)} km'),
                  if (court.isJoolaVerified)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Joola Verified',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${court.pricePerHour.toInt()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Text(
                    'per hour',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourtDetailsScreen(court: court),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
