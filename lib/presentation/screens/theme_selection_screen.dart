import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = [
      {
        'name': 'System Default',
        'description': 'Follow system theme',
        'selected': true,
        'icon': Icons.settings_system_daydream,
      },
      {
        'name': 'Light',
        'description': 'Light theme for daytime',
        'selected': false,
        'icon': Icons.light_mode,
      },
      {
        'name': 'Dark',
        'description': 'Dark theme for nighttime',
        'selected': false,
        'icon': Icons.dark_mode,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Theme'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          final theme = themes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                theme['icon'] as IconData,
                size: 32,
                color: theme['selected'] as bool
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              title: Text(theme['name'] as String),
              subtitle: Text(theme['description'] as String),
              trailing: theme['selected'] as bool
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                // TODO: Implement theme change
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Theme changed to ${theme['name']}',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Theme changes will be applied immediately',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
