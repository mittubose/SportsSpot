import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/presentation/screens/edit_profile_screen.dart';
import 'package:joola_spot/presentation/screens/update_phone_screen.dart';
import 'package:joola_spot/presentation/screens/update_email_screen.dart';
import 'package:joola_spot/presentation/screens/language_selection_screen.dart';
import 'package:joola_spot/presentation/screens/theme_selection_screen.dart';
import 'package:joola_spot/presentation/screens/terms_of_service_screen.dart';
import 'package:joola_spot/presentation/screens/privacy_policy_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Account'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text('Phone Number'),
            subtitle: const Text('+91 98765 43210'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdatePhoneScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email'),
            subtitle: const Text('john.doe@example.com'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateEmailScreen(),
                ),
              );
            },
          ),
          const _SectionHeader(title: 'Preferences'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push Notifications'),
            subtitle: const Text('Get updates about your bookings'),
            value: true,
            onChanged: (value) {
              // TODO: Implement notification toggle
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.location_on_outlined),
            title: const Text('Location Services'),
            subtitle: const Text('Show courts near you'),
            value: true,
            onChanged: (value) {
              // TODO: Implement location toggle
            },
          ),
          const _SectionHeader(title: 'App Settings'),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            subtitle: const Text('Light'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSelectionScreen(),
                ),
              );
            },
          ),
          const _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms of Service'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsOfServiceScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
