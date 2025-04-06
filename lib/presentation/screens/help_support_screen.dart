import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildContactCard(),
          const SizedBox(height: 24),
          _buildSection(
            'Frequently Asked Questions',
            [
              _buildFaqItem(
                'What is pickleball?',
                'Pickleball is a paddle sport that combines elements of tennis, badminton, and table tennis. It\'s played on a smaller court with a lower net, making it accessible for players of all ages.',
              ),
              _buildFaqItem(
                'How do I book a court?',
                'You can book a court by selecting your preferred venue, choosing an available time slot, and completing the payment. Bookings can be made up to 7 days in advance.',
              ),
              _buildFaqItem(
                'What is the cancellation policy?',
                'Free cancellation is available up to 24 hours before your booking. Cancellations within 24 hours will incur a 50% charge.',
              ),
              _buildFaqItem(
                'Do I need to bring my own equipment?',
                'Most courts offer equipment rental. Check the court details page to see if equipment rental is available at your chosen venue.',
              ),
              _buildFaqItem(
                'How do I get a refund?',
                'Refunds are automatically processed for eligible cancellations. The amount will be credited back to your original payment method within 5-7 business days.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Help Topics',
            [
              _buildHelpTopic('Booking Issues', Icons.calendar_today),
              _buildHelpTopic('Payment Problems', Icons.payment),
              _buildHelpTopic('Account Settings', Icons.person),
              _buildHelpTopic('Court Rules', Icons.rule),
              _buildHelpTopic('Safety Guidelines', Icons.health_and_safety),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildContactButton(
                    'Chat with Us',
                    Icons.chat,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildContactButton(
                    'Call Support',
                    Icons.phone,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 8),
                Text('Available 24/7'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(String text, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Implement contact actions
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpTopic(String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to help topic
        },
      ),
    );
  }
}
