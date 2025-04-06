import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Privacy Policy',
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
            title: '1. Information We Collect',
            content:
                'We collect information you provide directly, including:\n\n• Name and contact details\n• Location data for finding nearby courts\n• Payment information\n• Profile information and preferences\n• Device information and usage data',
          ),
          _Section(
            title: '2. How We Use Your Information',
            content:
                'We use your information to:\n\n• Process court bookings and payments\n• Provide personalized recommendations\n• Send booking confirmations and updates\n• Improve our services\n• Comply with legal obligations',
          ),
          _Section(
            title: '3. Information Sharing',
            content:
                'We share your information with:\n\n• Court facilities for booking confirmation\n• Payment processors for transactions\n• Service providers who assist our operations\n\nWe do not sell your personal information to third parties.',
          ),
          _Section(
            title: '4. Data Security',
            content:
                'We implement appropriate security measures to protect your information. Data is encrypted during transmission and storage. We comply with Indian data protection laws and regulations.',
          ),
          _Section(
            title: '5. Your Rights',
            content:
                'You have the right to:\n\n• Access your personal data\n• Correct inaccurate information\n• Delete your account\n• Opt-out of marketing communications\n• Export your data',
          ),
          _Section(
            title: '6. Location Services',
            content:
                'We use your location to show nearby courts and provide directions. You can disable location services through your device settings, but this may limit some app features.',
          ),
          _Section(
            title: '7. Cookies and Analytics',
            content:
                'We use cookies and similar technologies to improve user experience and analyze app usage. You can control cookie preferences through your device settings.',
          ),
          _Section(
            title: '8. Children\'s Privacy',
            content:
                'Our services are not intended for children under 13. We do not knowingly collect information from children under 13. If you believe we have collected such information, please contact us.',
          ),
          _Section(
            title: '9. Changes to Policy',
            content:
                'We may update this policy periodically. We will notify you of significant changes through the app or email.',
          ),
          SizedBox(height: 32),
          Text(
            'Contact Our Data Protection Officer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'For privacy-related inquiries:\n\nEmail: privacy@joolaspot.com\nPhone: +91 80 1234 5679\nAddress: 123 Sports Complex, Bangalore 560001\n\nWe aim to respond to privacy requests within 48 hours.',
          ),
          SizedBox(height: 24),
          Text(
            'Compliance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'This privacy policy complies with the Information Technology Act, 2000 and Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011.',
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
