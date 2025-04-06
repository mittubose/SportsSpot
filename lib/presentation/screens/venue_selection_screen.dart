import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/routes/app_router.dart';

final selectedSlotsProvider =
    StateProvider.family<Set<String>, String>((ref, courtId) => {});
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final showVerifiedOnlyProvider = StateProvider<bool>((ref) => false);
final priceRangeProvider =
    StateProvider<RangeValues>((ref) => const RangeValues(0, 1000));

class VenueSelectionScreen extends ConsumerWidget {
  const VenueSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courtsAsync = ref.watch(nearbyCourtsProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final showVerifiedOnly = ref.watch(showVerifiedOnlyProvider);
    final priceRange = ref.watch(priceRangeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Venue'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search venues...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 16),
                // Date selector
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected = date.day == selectedDate.day &&
                          date.month == selectedDate.month;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(DateFormat('EEE, MMM d').format(date)),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(selectedDateProvider.notifier).state =
                                  date;
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: courtsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              data: (courts) {
                final filteredCourts = courts.where((court) {
                  if (showVerifiedOnly && !court.isJoolaVerified) return false;
                  if (court.pricePerHour < priceRange.start ||
                      court.pricePerHour > priceRange.end) return false;
                  if (searchQuery.isNotEmpty) {
                    final query = searchQuery.toLowerCase();
                    return court.name.toLowerCase().contains(query) ||
                        court.address.toLowerCase().contains(query);
                  }
                  return true;
                }).toList();

                if (filteredCourts.isEmpty) {
                  return const Center(
                    child: Text('No venues found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredCourts.length,
                  itemBuilder: (context, index) {
                    final court = filteredCourts[index];
                    return _buildVenueCard(context, ref, court);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: courtsAsync.when(
        loading: () => null,
        error: (_, __) => null,
        data: (courts) => _buildBottomBar(context, ref, courts),
      ),
    );
  }

  Widget _buildVenueCard(BuildContext context, WidgetRef ref, Court court) {
    final selectedSlots = ref.watch(selectedSlotsProvider(court.id));
    final slots = _generateTimeSlots(court.openingHours, court.pricePerHour);
    final hasAvailableSlots = slots.isNotEmpty;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            enabled: hasAvailableSlots,
            leading: court.photoUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(court.photoUrl!),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.sports_tennis),
                  ),
            title: Text(
              court.name,
              style: hasAvailableSlots
                  ? null
                  : TextStyle(color: Theme.of(context).disabledColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(court.address),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(court.rating.toString()),
                    const SizedBox(width: 8),
                    if (court.isJoolaVerified)
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₹${court.pricePerHour}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: hasAvailableSlots
                            ? null
                            : Theme.of(context).disabledColor,
                      ),
                ),
                Text(
                  'per hour',
                  style: TextStyle(
                    color: hasAvailableSlots
                        ? null
                        : Theme.of(context).disabledColor,
                  ),
                ),
              ],
            ),
          ),
          if (hasAvailableSlots)
            ExpansionTile(
              title: const Text('Available Time Slots'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeGraph(context, ref, court, slots),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: slots.map((slot) {
                          final isSelected = selectedSlots.contains(
                              '${slot.startTime.millisecondsSinceEpoch}');
                          return FilterChip(
                            label: Text(
                              '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              final notifier = ref.read(
                                  selectedSlotsProvider(court.id).notifier);
                              if (selected) {
                                notifier.state = {
                                  ...selectedSlots,
                                  '${slot.startTime.millisecondsSinceEpoch}'
                                };
                              } else {
                                notifier.state = {
                                  for (final s in selectedSlots)
                                    if (s !=
                                        '${slot.startTime.millisecondsSinceEpoch}')
                                      s
                                };
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (court.gameRequirements.isNotEmpty)
            for (final requirement in court.gameRequirements) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Game Requirements',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text(
                            requirement.bringOwnPaddle
                                ? 'Bring Paddle'
                                : 'Paddle Provided',
                          ),
                          backgroundColor: requirement.bringOwnPaddle
                              ? Theme.of(context).colorScheme.errorContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                        ),
                        if (requirement.genderRestriction != null)
                          Chip(
                            label:
                                Text('${requirement.genderRestriction} Only'),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        Chip(
                          label: Text('Min Rating: ${requirement.minRating}'),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        ...requirement.requiredEquipment.map(
                          (e) => Chip(
                            label: Text(e),
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    if (requirement.notes != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        requirement.notes!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ],
        ],
      ),
    );
  }

  Widget _buildTimeGraph(
      BuildContext context, WidgetRef ref, Court court, List<TimeSlot> slots) {
    final openTime = _parseTime(court.openingHours.split('-')[0])!;
    final closeTime = _parseTime(court.openingHours.split('-')[1])!;
    final totalHours = closeTime.hour - openTime.hour;

    return SizedBox(
      height: 60,
      child: Row(
        children: List.generate(totalHours, (index) {
          final hour = openTime.hour + index;
          final isAvailable = slots.any((slot) => slot.startTime.hour == hour);
          return Expanded(
            child: Column(
              children: [
                Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
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

  Widget? _buildBottomBar(
      BuildContext context, WidgetRef ref, List<Court> courts) {
    final selectedSlots = courts
        .map((court) => ref.watch(selectedSlotsProvider(court.id)))
        .expand((slots) => slots)
        .toList();

    if (selectedSlots.isEmpty) return null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${selectedSlots.length} slot${selectedSlots.length > 1 ? 's' : ''} selected',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Total: ₹${selectedSlots.length * courts.first.pricePerHour}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              final court = courts.firstWhere((court) =>
                  ref.read(selectedSlotsProvider(court.id)).isNotEmpty);
              final selectedSlotIds = ref.read(selectedSlotsProvider(court.id));
              final slots =
                  _generateTimeSlots(court.openingHours, court.pricePerHour)
                      .where((slot) => selectedSlotIds
                          .contains('${slot.startTime.millisecondsSinceEpoch}'))
                      .toList();

              final venue = Venue(
                id: court.id,
                name: court.name,
                address: court.address,
                latitude: court.latitude,
                longitude: court.longitude,
                amenities: court.amenities,
                timeSlots: slots,
                currentBookings: [],
                publicGameIds: [],
                photoUrl: court.photoUrl,
                rating: court.rating,
                totalRatings: 0,
                isActive: true,
                createdAt: DateTime.now(),
                gameRequirements: court.gameRequirements,
              );
              Navigator.pop(context, venue);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Venues'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (context, ref, _) {
                final showVerifiedOnly = ref.watch(showVerifiedOnlyProvider);
                return SwitchListTile(
                  title: const Text('Show verified venues only'),
                  value: showVerifiedOnly,
                  onChanged: (value) {
                    ref.read(showVerifiedOnlyProvider.notifier).state = value;
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, _) {
                final priceRange = ref.watch(priceRangeProvider);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price Range (per hour)'),
                    RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 1000,
                      divisions: 10,
                      labels: RangeLabels(
                        '₹${priceRange.start.round()}',
                        '₹${priceRange.end.round()}',
                      ),
                      onChanged: (values) {
                        ref.read(priceRangeProvider.notifier).state = values;
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(showVerifiedOnlyProvider.notifier).state = false;
              ref.read(priceRangeProvider.notifier).state =
                  const RangeValues(0, 1000);
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  List<TimeSlot> _generateTimeSlots(String openingHours, double pricePerHour) {
    final now = DateTime.now();
    final selectedDate = now; // TODO: Use selected date from provider
    final slots = <TimeSlot>[];
    final today =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    // Parse opening hours string (format: "10:00-22:00")
    final times = openingHours.split('-');
    if (times.length != 2) return slots;

    final openTime = _parseTime(times[0]);
    final closeTime = _parseTime(times[1]);

    if (openTime != null && closeTime != null) {
      var currentSlot = DateTime(
        today.year,
        today.month,
        today.day,
        openTime.hour,
        openTime.minute,
      );

      while (currentSlot.isBefore(DateTime(
        today.year,
        today.month,
        today.day,
        closeTime.hour,
        closeTime.minute,
      ))) {
        final endTime = currentSlot.add(const Duration(hours: 1));
        if (currentSlot.isAfter(now)) {
          slots.add(
            TimeSlot(
              id: '${currentSlot.millisecondsSinceEpoch}',
              startTime: currentSlot,
              endTime: endTime,
              price: pricePerHour,
              isAvailable: true,
            ),
          );
        }
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
