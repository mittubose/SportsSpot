import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> languages = [
      {'name': 'English', 'code': 'en', 'selected': true},
      {'name': 'हिंदी', 'code': 'hi', 'selected': false},
      {'name': 'தமிழ்', 'code': 'ta', 'selected': false},
      {'name': 'తెలుగు', 'code': 'te', 'selected': false},
      {'name': 'ಕನ್ನಡ', 'code': 'kn', 'selected': false},
      {'name': 'മലയാളം', 'code': 'ml', 'selected': false},
      {'name': 'मराठी', 'code': 'mr', 'selected': false},
      {'name': 'ગુજરાતી', 'code': 'gu', 'selected': false},
      {'name': 'বাংলা', 'code': 'bn', 'selected': false},
      {'name': 'ਪੰਜਾਬੀ', 'code': 'pa', 'selected': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final language = languages[index];
          return ListTile(
            title: Text(language['name'] as String),
            trailing: language['selected'] as bool
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () {
              // TODO: Implement language change
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Language changed to ${language['name']}',
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Note: Changing the language will restart the app',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
