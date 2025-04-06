import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsOfServiceScreen extends ConsumerWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Terms of Service',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Last updated: March 15, 2024',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 24),
          _Section(
            title: '1. Acceptance of Terms',
            content:
                'By accessing and using the Joola Spot app, you agree to be bound by these Terms of Service and all applicable laws and regulations.',
          ),
          _Section(
            title: '2. Court Bookings',
            content:
                'Users must be at least 13 years old to book courts. Bookings are subject to availability and court-specific rules. Cancellations must be made at least 4 hours before the scheduled time to receive a full refund.',
          ),
          _Section(
            title: '3. Payment Terms',
            content:
                'All payments are processed in Indian Rupees (INR). We accept various payment methods including UPI, credit/debit cards, and net banking. Refunds will be processed to the original payment method.',
          ),
          _Section(
            title: '4. Court Rules',
            content:
                'Players must follow standard pickleball rules and etiquette. Proper court shoes are required. No food or drinks (except water) allowed on courts. Players are responsible for any damage to facilities.',
          ),
          _Section(
            title: '5. User Conduct',
            content:
                'Users must behave respectfully towards other players and staff. Harassment, discrimination, or unsportsmanlike conduct will not be tolerated and may result in account suspension.',
          ),
          _Section(
            title: '6. Safety Guidelines',
            content:
                'Players participate at their own risk and should have appropriate health insurance. We recommend warming up before play and using proper safety equipment.',
          ),
          _Section(
            title: '7. Account Security',
            content:
                'Users are responsible for maintaining the confidentiality of their account credentials. Any suspicious activity should be reported immediately.',
          ),
          _Section(
            title: '8. Modifications',
            content:
                'We reserve the right to modify these terms at any time. Users will be notified of significant changes via email or app notification.',
          ),
          _Section(
            title: '9. Governing Law',
            content:
                'These terms are governed by the laws of India. Any disputes shall be subject to the exclusive jurisdiction of courts in Bangalore, Karnataka.',
          ),
          SizedBox(height: 32),
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'If you have any questions about these Terms of Service, please contact us at:\n\nEmail: support@joolaspot.com\nPhone: +91 80 1234 5678\nAddress: 123 Sports Complex, Bangalore 560001',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
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
          Text(content),
        ],
      ),
    );
  }
}
