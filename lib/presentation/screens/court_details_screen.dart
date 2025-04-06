import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/presentation/screens/court_booking_screen.dart';
import 'package:joola_spot/presentation/screens/public_games_screen.dart';

class CourtDetailsScreen extends ConsumerWidget {
  final Court court;

  const CourtDetailsScreen({super.key, required this.court});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Generate all time slots for the day
    final allSlots = _generateTimeSlots(today, court.openingHours);

    // Mark booked slots
    for (final bookedSlot in court.bookedSlots) {
      final index = allSlots.indexWhere(
        (slot) => slot.startTime.hour == bookedSlot.startTime.hour,
      );
      if (index != -1) {
        allSlots[index] = bookedSlot;
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(court.name),
              background: court.photoUrl != null
                  ? Image.network(
                      court.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.sports_tennis, size: 50),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 20),
                      const SizedBox(width: 4),
                      Text(
                        court.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (court.isJoolaVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Joola Verified',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    court.address,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Timings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    court.openingHours,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${court.pricePerHour.toInt()} per hour',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: court.amenities.map((amenity) {
                      return Chip(
                        label: Text(amenity),
                        backgroundColor: Colors.grey[200],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Time Slots',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildTimeGraph(context, allSlots),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allSlots.map((slot) {
                      final isBooked = !slot.isAvailable;
                      final isPublicGame = slot.gameId != null;
                      return FilterChip(
                        label: Text(
                          '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                        ),
                        selected: isBooked,
                        onSelected: isBooked
                            ? null
                            : (selected) {
                                // TODO: Handle slot selection
                              },
                        backgroundColor: isPublicGame
                            ? Theme.of(context).colorScheme.tertiary
                            : null,
                        labelStyle: TextStyle(
                          color: isPublicGame
                              ? Theme.of(context).colorScheme.onTertiary
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          if (court.publicGames.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Public Games',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PublicGamesScreen(),
                              ),
                            );
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...court.publicGames.map((game) => Card(
                          child: ListTile(
                            title: Text(game.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('h:mm a').format(game.startTime)} - ${DateFormat('h:mm a').format(game.endTime)}',
                                ),
                                Text(
                                  '${game.currentPlayers}/${game.maxPlayers} players • ${game.skillLevel} • ${game.gameType}',
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹${game.pricePerPlayer}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const Text('per player'),
                              ],
                            ),
                            isThreeLine: true,
                            onTap: () {
                              // TODO: Navigate to game details
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourtBookingScreen(court: court),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Book Now'),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  // TODO: Implement share functionality
                },
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeGraph(BuildContext context, List<TimeSlot> slots) {
    final openTime = _parseTime(court.openingHours.split('-')[0])!;
    final closeTime = _parseTime(court.openingHours.split('-')[1])!;
    final totalHours = closeTime.hour - openTime.hour;

    return SizedBox(
      height: 60,
      child: Row(
        children: List.generate(totalHours, (index) {
          final hour = openTime.hour + index;
          final slot = slots.firstWhere(
            (slot) => slot.startTime.hour == hour,
            orElse: () => TimeSlot(
              id: '$hour',
              startTime: DateTime(2024, 1, 1, hour),
              endTime: DateTime(2024, 1, 1, hour + 1),
              price: court.pricePerHour,
              isAvailable: true,
            ),
          );
          final isPublicGame = slot.gameId != null;
          return Expanded(
            child: Column(
              children: [
                Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: !slot.isAvailable
                        ? isPublicGame
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.surfaceVariant
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${hour % 12 == 0 ? 12 : hour % 12}${hour < 12 ? 'am' : 'pm'}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<TimeSlot> _generateTimeSlots(DateTime date, String openingHours) {
    final slots = <TimeSlot>[];
    final times = openingHours.split('-');
    if (times.length != 2) return slots;

    final openTime = _parseTime(times[0]);
    final closeTime = _parseTime(times[1]);

    if (openTime != null && closeTime != null) {
      var currentSlot = DateTime(
        date.year,
        date.month,
        date.day,
        openTime.hour,
        openTime.minute,
      );

      while (currentSlot.isBefore(DateTime(
        date.year,
        date.month,
        date.day,
        closeTime.hour,
        closeTime.minute,
      ))) {
        final endTime = currentSlot.add(const Duration(hours: 1));
        slots.add(
          TimeSlot(
            id: '${currentSlot.millisecondsSinceEpoch}',
            startTime: currentSlot,
            endTime: endTime,
            price: court.pricePerHour,
            isAvailable: true,
          ),
        );
        currentSlot = endTime;
      }
    }

    return slots;
  }

  TimeOfDay? _parseTime(String time) {
    final parts = time.trim().split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }
}
