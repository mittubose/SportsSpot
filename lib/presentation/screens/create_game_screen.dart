import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/presentation/screens/venue_selection_screen.dart';

class CreateGameScreen extends ConsumerStatefulWidget {
  const CreateGameScreen({super.key});

  @override
  ConsumerState<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends ConsumerState<CreateGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _selectedDate = StateProvider<DateTime>((ref) => DateTime.now());
  final _selectedVenue = StateProvider<Venue?>((ref) => null);
  final _selectedTimeSlot = StateProvider<TimeSlot?>((ref) => null);
  final _availableTimeSlots = StateProvider<List<TimeSlot>>((ref) => []);
  final _selectedPrivacy =
      StateProvider<GamePrivacy>((ref) => GamePrivacy.public);
  final _selectedGameType = StateProvider<GameType>((ref) => GameType.casual);
  final _selectedSkillLevel =
      StateProvider<SkillLevel>((ref) => SkillLevel.beginner);
  final _playerCount = StateProvider<int>((ref) => 2);
  final _selectedRequirements = StateProvider<List<String>>((ref) => []);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectVenue(BuildContext context) async {
    final selectedVenue = await Navigator.push<Venue>(
      context,
      MaterialPageRoute(
        builder: (context) => const VenueSelectionScreen(),
      ),
    );

    if (selectedVenue != null) {
      ref.read(_selectedVenue.notifier).state = selectedVenue;
      _updateAvailableTimeSlots();
    }
  }

  void _updateAvailableTimeSlots() {
    final venue = ref.read(_selectedVenue);
    if (venue != null) {
      final selectedDate = ref.read(_selectedDate);
      final slots = venue.getAvailableSlots(selectedDate);
      ref.read(_availableTimeSlots.notifier).state = slots;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedVenue = ref.watch(_selectedVenue);
    final selectedTimeSlot = ref.watch(_selectedTimeSlot);
    final availableTimeSlots = ref.watch(_availableTimeSlots);
    final selectedPrivacy = ref.watch(_selectedPrivacy);
    final selectedGameType = ref.watch(_selectedGameType);
    final selectedSkillLevel = ref.watch(_selectedSkillLevel);
    final playerCount = ref.watch(_playerCount);
    final selectedRequirements = ref.watch(_selectedRequirements);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Game'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Game Title',
                hintText: 'Enter a title for your game',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Select Venue'),
              subtitle: selectedVenue != null
                  ? Text(selectedVenue.name)
                  : const Text('No venue selected'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _selectVenue(context),
            ),
            if (selectedVenue != null) ...[
              const SizedBox(height: 16),
              const Text('Available Time Slots'),
              const SizedBox(height: 8),
              if (availableTimeSlots.isEmpty)
                const Text('No time slots available for selected date')
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: availableTimeSlots.map((slot) {
                    final isSelected = selectedTimeSlot == slot;
                    return FilterChip(
                      label: Text(
                          '${DateFormat('HH:mm').format(slot.startTime)} - ${DateFormat('HH:mm').format(slot.endTime)}'),
                      selected: isSelected,
                      onSelected: (selected) {
                        ref.read(_selectedTimeSlot.notifier).state =
                            selected ? slot : null;
                      },
                    );
                  }).toList(),
                ),
            ],
            const SizedBox(height: 16),
            DropdownButtonFormField<GamePrivacy>(
              value: selectedPrivacy,
              decoration: const InputDecoration(
                labelText: 'Privacy',
              ),
              items: GamePrivacy.values.map((privacy) {
                return DropdownMenuItem(
                  value: privacy,
                  child: Text(privacy.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(_selectedPrivacy.notifier).state = value;
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GameType>(
              value: selectedGameType,
              decoration: const InputDecoration(
                labelText: 'Game Type',
              ),
              items: GameType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(_selectedGameType.notifier).state = value;
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<SkillLevel>(
              value: selectedSkillLevel,
              decoration: const InputDecoration(
                labelText: 'Skill Level',
              ),
              items: SkillLevel.values.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(_selectedSkillLevel.notifier).state = value;
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description for your game',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: selectedVenue != null && selectedTimeSlot != null
              ? () => _createGame()
              : null,
          child: const Text('Create Game'),
        ),
      ),
    );
  }

  void _createGame() {
    if (_formKey.currentState?.validate() ?? false) {
      final selectedVenue = ref.read(_selectedVenue);
      if (selectedVenue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a venue'),
          ),
        );
        return;
      }

      final selectedTimeSlot = ref.read(_selectedTimeSlot);
      if (selectedTimeSlot == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time slot'),
          ),
        );
        return;
      }

      // TODO: Create game with selected venue and time slot
      final game = Game(
        id: '', // TODO: Generate ID
        title: _titleController.text,
        dateTime: selectedTimeSlot.startTime,
        playerCount: ref.read(_playerCount),
        privacy: ref.read(_selectedPrivacy),
        gameType: ref.read(_selectedGameType),
        skillLevel: ref.read(_selectedSkillLevel),
        venue: selectedVenue,
        players: [], // TODO: Add current user
        requirements: ref.read(_selectedRequirements),
        description: _descriptionController.text,
        isActive: true,
        createdAt: DateTime.now(),
        createdBy: '', // TODO: Add current user ID
      );

      // TODO: Save game and navigate back
    }
  }
}
