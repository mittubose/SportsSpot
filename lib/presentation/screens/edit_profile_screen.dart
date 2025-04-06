import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Save profile changes
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://placekitten.com/200/200', // Placeholder
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: Implement image picker
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              initialValue: 'John',
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Doe',
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Intermediate',
              decoration: const InputDecoration(
                labelText: 'Skill Level',
                border: OutlineInputBorder(),
                helperText: 'Your pickleball playing level',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Bangalore',
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Right',
              decoration: const InputDecoration(
                labelText: 'Playing Hand',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Playing Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Singles'),
                  selected: true,
                  onSelected: (bool selected) {},
                ),
                FilterChip(
                  label: const Text('Doubles'),
                  selected: true,
                  onSelected: (bool selected) {},
                ),
                FilterChip(
                  label: const Text('Mixed Doubles'),
                  selected: false,
                  onSelected: (bool selected) {},
                ),
                FilterChip(
                  label: const Text('Tournaments'),
                  selected: false,
                  onSelected: (bool selected) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 3,
              initialValue:
                  'Runner-up in Bangalore Pickleball Championship 2023\nWinner of DLF Club Monthly Tournament',
              decoration: const InputDecoration(
                labelText: 'List your pickleball achievements',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
