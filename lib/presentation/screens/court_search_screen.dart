import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/screens/court_details_screen.dart';

class CourtSearchScreen extends ConsumerStatefulWidget {
  const CourtSearchScreen({super.key});

  @override
  ConsumerState<CourtSearchScreen> createState() => _CourtSearchScreenState();
}

class _CourtSearchScreenState extends ConsumerState<CourtSearchScreen> {
  final _searchController = TextEditingController();
  final _filters = {
    'priceRange': RangeValues(200, 1000),
    'rating': 0.0,
    'amenities': <String>{},
    'availability': 'Any Time',
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search courts...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _searchController.clear(),
            ),
          ),
          onChanged: (value) {
            // TODO: Implement search
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: ref.watch(nearbyCourtsProvider).when(
            data: (courts) => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courts.length,
              itemBuilder: (context, index) {
                final court = courts[index];
                return _CourtCard(court: court);
              },
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text('Error: $error'),
            ),
          ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              AppBar(
                title: const Text('Filters'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _filters['priceRange'] = const RangeValues(200, 1000);
                        _filters['rating'] = 0.0;
                        _filters['amenities'] = <String>{};
                        _filters['availability'] = 'Any Time';
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Price Range (₹/hour)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RangeSlider(
                      values: _filters['priceRange'] as RangeValues,
                      min: 200,
                      max: 1000,
                      divisions: 16,
                      labels: RangeLabels(
                        '₹${(_filters['priceRange'] as RangeValues).start.round()}',
                        '₹${(_filters['priceRange'] as RangeValues).end.round()}',
                      ),
                      onChanged: (values) {
                        setState(() {
                          _filters['priceRange'] = values;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Minimum Rating',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _filters['rating'] as double,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: (_filters['rating'] as double).toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _filters['rating'] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Amenities',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        _FilterChip(
                          label: 'Parking',
                          selected: (_filters['amenities'] as Set<String>)
                              .contains('Parking'),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                (_filters['amenities'] as Set<String>)
                                    .add('Parking');
                              } else {
                                (_filters['amenities'] as Set<String>)
                                    .remove('Parking');
                              }
                            });
                          },
                        ),
                        _FilterChip(
                          label: 'Washroom',
                          selected: (_filters['amenities'] as Set<String>)
                              .contains('Washroom'),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                (_filters['amenities'] as Set<String>)
                                    .add('Washroom');
                              } else {
                                (_filters['amenities'] as Set<String>)
                                    .remove('Washroom');
                              }
                            });
                          },
                        ),
                        _FilterChip(
                          label: 'Water',
                          selected: (_filters['amenities'] as Set<String>)
                              .contains('Water'),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                (_filters['amenities'] as Set<String>)
                                    .add('Water');
                              } else {
                                (_filters['amenities'] as Set<String>)
                                    .remove('Water');
                              }
                            });
                          },
                        ),
                        _FilterChip(
                          label: 'Lighting',
                          selected: (_filters['amenities'] as Set<String>)
                              .contains('Lighting'),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                (_filters['amenities'] as Set<String>)
                                    .add('Lighting');
                              } else {
                                (_filters['amenities'] as Set<String>)
                                    .remove('Lighting');
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Availability',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        'Any Time',
                        'Morning',
                        'Afternoon',
                        'Evening',
                        'Night',
                      ]
                          .map((time) => ChoiceChip(
                                label: Text(time),
                                selected: _filters['availability'] == time,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _filters['availability'] = time;
                                    }
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Apply filters
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
    );
  }
}

class _CourtCard extends StatelessWidget {
  final Court court;

  const _CourtCard({required this.court});

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (court.photoUrl != null)
              Image.network(
                court.photoUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.sports_tennis,
                  size: 64,
                  color: Colors.grey,
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
                      Text(
                        '₹${court.pricePerHour}/hr',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    court.address,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        court.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        court.openingHours,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
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
