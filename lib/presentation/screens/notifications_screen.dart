import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to notification settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationGroup(
            'Today',
            [
              _buildNotification(
                'Booking Reminder',
                'Your court booking at DLF Sports Complex is in 2 hours',
                DateTime.now().subtract(const Duration(hours: 1)),
                Icons.calendar_today,
                Colors.blue,
              ),
              _buildNotification(
                'Payment Success',
                'Payment of ₹1,600 for DLF Sports Complex booking was successful',
                DateTime.now().subtract(const Duration(hours: 2)),
                Icons.payment,
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildNotificationGroup(
            'Yesterday',
            [
              _buildNotification(
                'New Court Added',
                'Check out the new pickleball court at Powai Sports Club',
                DateTime.now().subtract(const Duration(days: 1)),
                Icons.sports_tennis,
                Colors.purple,
              ),
              _buildNotification(
                'Booking Cancelled',
                'Your booking at Siri Fort Sports Complex was cancelled',
                DateTime.now().subtract(const Duration(days: 1, hours: 5)),
                Icons.cancel,
                Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildNotificationGroup(
            'This Week',
            [
              _buildNotification(
                'Special Offer',
                'Get 20% off on morning slots at Koramangala Indoor Stadium',
                DateTime.now().subtract(const Duration(days: 3)),
                Icons.local_offer,
                Colors.orange,
              ),
              _buildNotification(
                'Court Maintenance',
                'DLF Sports Complex Court 2 will be under maintenance on Sunday',
                DateTime.now().subtract(const Duration(days: 4)),
                Icons.build,
                Colors.brown,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(String title, List<Widget> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...notifications,
      ],
    );
  }

  Widget _buildNotification(
    String title,
    String message,
    DateTime time,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              _getTimeAgo(time),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'mark_read',
              child: Text('Mark as Read'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          onSelected: (value) {
            // TODO: Implement notification actions
          },
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
