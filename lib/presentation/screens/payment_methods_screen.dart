import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'UPI',
            [
              _buildPaymentMethod(
                'Google Pay',
                'user@okicici',
                Icons.g_mobiledata,
                isDefault: true,
              ),
              _buildPaymentMethod(
                'PhonePe',
                'user@ybl',
                Icons.phone_android,
              ),
              _buildPaymentMethod(
                'Paytm UPI',
                'user@paytm',
                Icons.payment,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Cards',
            [
              _buildPaymentMethod(
                'HDFC Bank',
                '•••• •••• •••• 1234',
                Icons.credit_card,
              ),
              _buildPaymentMethod(
                'ICICI Bank',
                '•••• •••• •••• 5678',
                Icons.credit_card,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Net Banking',
            [
              _buildPaymentMethod(
                'HDFC Bank',
                'Net Banking',
                Icons.account_balance,
              ),
              _buildPaymentMethod(
                'SBI',
                'Net Banking',
                Icons.account_balance,
              ),
              _buildPaymentMethod(
                'ICICI Bank',
                'Net Banking',
                Icons.account_balance,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add payment method
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add payment method coming soon!'),
            ),
          );
        },
        child: const Icon(Icons.add),
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
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildPaymentMethod(
    String title,
    String subtitle,
    IconData icon, {
    bool isDefault = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Row(
          children: [
            Text(title),
            if (isDefault) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(subtitle),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            if (!isDefault)
              const PopupMenuItem(
                value: 'make_default',
                child: Text('Make Default'),
              ),
            const PopupMenuItem(
              value: 'remove',
              child: Text('Remove'),
            ),
          ],
          onSelected: (value) {
            // TODO: Implement payment method actions
          },
        ),
      ),
    );
  }
}
