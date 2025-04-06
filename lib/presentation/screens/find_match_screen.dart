import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/providers/match_provider.dart';
import 'package:joola_spot/presentation/widgets/match_card.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final selectedGameTypeProvider = StateProvider<GameType?>((ref) => null);
final selectedSkillLevelProvider = StateProvider<SkillLevel?>((ref) => null);

class FindMatchScreen extends ConsumerWidget {
  const FindMatchScreen({super.key});

  Widget _buildFilters(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedGameType = ref.watch(selectedGameTypeProvider);
    final selectedSkillLevel = ref.watch(selectedSkillLevelProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ActionChip(
            label: Text(DateFormat('MMM d').format(selectedDate)),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) {
                ref.read(selectedDateProvider.notifier).state = date;
              }
            },
            avatar: const Icon(Icons.calendar_today, size: 16),
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Casual'),
            selected: selectedGameType == GameType.casual,
            onSelected: (selected) {
              ref.read(selectedGameTypeProvider.notifier).state =
                  selected ? GameType.casual : null;
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Pro'),
            selected: selectedGameType == GameType.pro,
            onSelected: (selected) {
              ref.read(selectedGameTypeProvider.notifier).state =
                  selected ? GameType.pro : null;
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Beginner'),
            selected: selectedSkillLevel == SkillLevel.beginner,
            onSelected: (selected) {
              ref.read(selectedSkillLevelProvider.notifier).state =
                  selected ? SkillLevel.beginner : null;
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Intermediate'),
            selected: selectedSkillLevel == SkillLevel.intermediate,
            onSelected: (selected) {
              ref.read(selectedSkillLevelProvider.notifier).state =
                  selected ? SkillLevel.intermediate : null;
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Pro'),
            selected: selectedSkillLevel == SkillLevel.pro,
            onSelected: (selected) {
              ref.read(selectedSkillLevelProvider.notifier).state =
                  selected ? SkillLevel.pro : null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find a Match'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Matches'),
              Tab(text: 'Venues'),
            ],
          ),
        ),
        body: Column(
          children: [
            Consumer(builder: (context, ref, _) => _buildFilters(context, ref)),
            Expanded(
              child: TabBarView(
                children: [
                  Consumer(
                      builder: (context, ref, _) => _buildMatchesList(ref)),
                  Consumer(
                      builder: (context, ref, _) => _buildVenueSlotsList(ref)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchesList(WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedGameType = ref.watch(selectedGameTypeProvider);
    final selectedSkillLevel = ref.watch(selectedSkillLevelProvider);
    final matchesAsync = ref.watch(publicMatchesProvider(selectedDate));

    return matchesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      data: (matches) {
        // Filter matches based on selected filters
        final filteredMatches = matches.where((match) {
          if (selectedGameType != null && match.gameType != selectedGameType) {
            return false;
          }
          if (selectedSkillLevel != null &&
              match.skillLevel != selectedSkillLevel) {
            return false;
          }
          return true;
        }).toList();

        if (filteredMatches.isEmpty) {
          return const Center(
            child: Text('No matches found'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredMatches.length,
          itemBuilder: (context, index) {
            final match = filteredMatches[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MatchCard(
                title: match.title,
                venue: match.venue.name,
                time: DateFormat('h:mm a').format(match.dateTime),
                players: '${match.players.length}/${match.playerCount}',
                skillLevel: match.skillLevel,
                gameType: match.gameType,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVenueSlotsList(WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final venuesAsync = ref.watch(venueAvailabilityProvider(selectedDate));

    return venuesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      data: (venues) {
        if (venues.isEmpty) {
          return const Center(
            child: Text('No venues available'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: venues.length,
          itemBuilder: (context, index) {
            final venue = venues[index];
            final availableSlots = venue.getAvailableSlots(selectedDate);
            final bookedSlots =
                venue.timeSlots.where((slot) => !slot.isAvailable).toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: venue.photoUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(venue.photoUrl!),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.sports_tennis),
                          ),
                    title: Text(venue.name),
                    subtitle: Text(venue.address),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₹${availableSlots.isNotEmpty ? availableSlots.first.price : 0}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'per hour',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (availableSlots.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Available Slots',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableSlots.map((slot) {
                          return Chip(
                            label: Text(
                              '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  if (bookedSlots.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        'Booked Slots',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: bookedSlots.map((slot) {
                          return Chip(
                            label: Text(
                              '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
