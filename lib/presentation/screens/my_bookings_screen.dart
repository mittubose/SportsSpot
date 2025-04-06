import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingBookings(),
            _buildPastBookings(),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBookings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          courtName: 'DLF Sports Complex',
          date: 'Today',
          time: '7:00 PM - 9:00 PM',
          price: '₹1,600',
          status: 'Confirmed',
          statusColor: Colors.green,
        ),
        _buildBookingCard(
          courtName: 'Siri Fort Sports Complex',
          date: 'Tomorrow',
          time: '6:00 PM - 7:00 PM',
          price: '₹600',
          status: 'Pending',
          statusColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildPastBookings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          courtName: 'Koramangala Indoor Stadium',
          date: '15 Mar 2024',
          time: '8:00 AM - 9:00 AM',
          price: '₹500',
          status: 'Completed',
          statusColor: Colors.grey,
        ),
        _buildBookingCard(
          courtName: 'Powai Sports Club',
          date: '10 Mar 2024',
          time: '7:00 PM - 9:00 PM',
          price: '₹1,400',
          status: 'Completed',
          statusColor: Colors.grey,
        ),
        _buildBookingCard(
          courtName: 'DLF Sports Complex',
          date: '5 Mar 2024',
          time: '6:00 PM - 8:00 PM',
          price: '₹1,600',
          status: 'Cancelled',
          statusColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required String courtName,
    required String date,
    required String time,
    required String price,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  courtName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(date),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount: $price',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (status == 'Confirmed')
                  TextButton(
                    onPressed: () {
                      // TODO: Implement cancellation
                    },
                    child: const Text('Cancel Booking'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
