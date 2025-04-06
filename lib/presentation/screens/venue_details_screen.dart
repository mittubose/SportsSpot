import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/venue.dart';

class VenueDetailsScreen extends ConsumerStatefulWidget {
  final Venue venue;

  const VenueDetailsScreen({
    super.key,
    required this.venue,
  });

  @override
  ConsumerState<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends ConsumerState<VenueDetailsScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVenueInfo(),
                  const SizedBox(height: 24),
                  _buildAmenities(),
                  const SizedBox(height: 24),
                  _buildDateSelector(),
                  const SizedBox(height: 16),
                  _buildTimeSlots(),
                  const SizedBox(height: 24),
                  _buildPublicGames(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.venue.name),
        background: widget.venue.photoUrl != null
            ? Image.network(
                widget.venue.photoUrl!,
                fit: BoxFit.cover,
              )
            : Container(
                color: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.sports_tennis,
                  size: 64,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildVenueInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.venue.address,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              widget.venue.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 4),
            Text(
              '(${widget.venue.totalRatings})',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.venue.amenities.map((amenity) {
            return Chip(
              label: Text(amenity),
              avatar: const Icon(Icons.check_circle),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Slots',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _selectedDate.day == date.day &&
                  _selectedDate.month == date.month &&
                  _selectedDate.year == date.year;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots() {
    final availableSlots = widget.venue.getAvailableSlots(_selectedDate);

    if (availableSlots.isEmpty) {
      return const Center(
        child: Text('No slots available for this date'),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableSlots.map((slot) {
        return ActionChip(
          label: Text(
            '${_formatTime(slot.startTime)} - ${_formatTime(slot.endTime)}',
          ),
          onPressed: () {
            // TODO: Navigate to booking screen
          },
        );
      }).toList(),
    );
  }

  Widget _buildPublicGames() {
    if (widget.venue.publicGameIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Public Games',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        // TODO: Implement public games list
      ],
    );
  }

  String _getDayName(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
