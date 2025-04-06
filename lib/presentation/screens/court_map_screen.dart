import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/screens/court_details_screen.dart';
import 'package:joola_spot/presentation/screens/court_search_screen.dart';

class CourtMapScreen extends ConsumerWidget {
  const CourtMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Courts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourtSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Text('Map View Coming Soon!'),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nearby Courts',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filter'),
                            onPressed: () {
                              // TODO: Implement filters
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ref.watch(nearbyCourtsProvider).when(
                            data: (courts) => ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.all(16),
                              itemCount: courts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final court = courts[index];
                                return _CourtListItem(court: court);
                              },
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stackTrace) => Center(
                              child: Text('Error: $error'),
                            ),
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CourtListItem extends StatelessWidget {
  final Court court;

  const _CourtListItem({required this.court});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          image: court.photoUrl != null
              ? DecorationImage(
                  image: NetworkImage(court.photoUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: court.photoUrl == null
            ? const Icon(Icons.sports_tennis, color: Colors.grey)
            : null,
      ),
      title: Text(court.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            court.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
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
                style: Theme.of(context).textTheme.bodySmall,
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
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₹${court.pricePerHour}/hr',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (court.distance != null)
            Text(
              '${court.distance!.toStringAsFixed(1)} km',
              style: Theme.of(context).textTheme.bodySmall,
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
  }
}
