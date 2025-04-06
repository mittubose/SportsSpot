import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/presentation/screens/venue_selection_screen.dart';
import 'package:joola_spot/presentation/screens/player_search_dialog.dart';
import 'package:joola_spot/presentation/widgets/time_slot_selector.dart';

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
  final _selectedPlayers = StateProvider<List<PlayerProfile>>((ref) => []);

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

  void _showPlayerSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => PlayerSearchDialog(
        onPlayerSelected: (player) {
          final players = List<PlayerProfile>.from(ref.read(_selectedPlayers));
          if (!players.contains(player)) {
            players.add(player);
            ref.read(_selectedPlayers.notifier).state = players;
          }
        },
      ),
    );
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
    final selectedPlayers = ref.watch(_selectedPlayers);

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
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description for your game',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: playerCount,
              decoration: const InputDecoration(
                labelText: 'Number of Players',
              ),
              items: [2, 4, 6, 8].map((count) {
                return DropdownMenuItem(
                  value: count,
                  child: Text(count.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(_playerCount.notifier).state = value;
                }
              },
            ),
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
            ListTile(
              title: const Text('Select Venue'),
              subtitle: selectedVenue != null
                  ? Text(selectedVenue.name)
                  : const Text('No venue selected'),
              onTap: () => _selectVenue(context),
            ),
            if (selectedVenue != null) ...[
              const SizedBox(height: 16),
              const Text('Available Time Slots'),
              TimeSlotSelector(
                availableSlots: availableTimeSlots,
                onSlotSelected: (timeSlot) {
                  ref.read(_selectedTimeSlot.notifier).state = timeSlot;
                },
                selectedSlot: selectedTimeSlot,
              ),
            ],
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('Game Requirements'),
              children: [
                CheckboxListTile(
                  title: const Text('Bring your own bat'),
                  value: selectedRequirements.contains('bring_bat'),
                  onChanged: (value) {
                    final requirements =
                        List<String>.from(selectedRequirements);
                    if (value ?? false) {
                      requirements.add('bring_bat');
                    } else {
                      requirements.remove('bring_bat');
                    }
                    ref.read(_selectedRequirements.notifier).state =
                        requirements;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Women only'),
                  value: selectedRequirements.contains('women_only'),
                  onChanged: (value) {
                    final requirements =
                        List<String>.from(selectedRequirements);
                    if (value ?? false) {
                      requirements.add('women_only');
                    } else {
                      requirements.remove('women_only');
                    }
                    ref.read(_selectedRequirements.notifier).state =
                        requirements;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Men only'),
                  value: selectedRequirements.contains('men_only'),
                  onChanged: (value) {
                    final requirements =
                        List<String>.from(selectedRequirements);
                    if (value ?? false) {
                      requirements.add('men_only');
                    } else {
                      requirements.remove('men_only');
                    }
                    ref.read(_selectedRequirements.notifier).state =
                        requirements;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Pro match'),
                  value: selectedRequirements.contains('pro_match'),
                  onChanged: (value) {
                    final requirements =
                        List<String>.from(selectedRequirements);
                    if (value ?? false) {
                      requirements.add('pro_match');
                    } else {
                      requirements.remove('pro_match');
                    }
                    ref.read(_selectedRequirements.notifier).state =
                        requirements;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showPlayerSearchDialog(),
              child: const Text('Add Players'),
            ),
            if (selectedPlayers.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Selected Players (${selectedPlayers.length})'),
              Wrap(
                spacing: 8,
                children: selectedPlayers.map((player) {
                  return Chip(
                    avatar: CircleAvatar(
                      backgroundImage: player.profilePicUrl != null
                          ? NetworkImage(player.profilePicUrl!)
                          : null,
                    ),
                    label: Text(player.name),
                    onDeleted: () {
                      final players = List<PlayerProfile>.from(selectedPlayers);
                      players.remove(player);
                      ref.read(_selectedPlayers.notifier).state = players;
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _formKey.currentState?.validate() ?? false
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final game = Game(
                          id: DateTime.now().toString(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dateTime: selectedTimeSlot!.startTime,
                          playerCount: playerCount,
                          privacy: selectedPrivacy,
                          gameType: selectedGameType,
                          skillLevel: selectedSkillLevel,
                          venue: selectedVenue!,
                          players: selectedPlayers
                              .map((profile) => Player(
                                    id: profile.id,
                                    name: profile.name,
                                    photoUrl: profile.profilePicUrl,
                                    privacy: PlayerPrivacy.public,
                                    ratings: [],
                                    badges: [],
                                    friendIds: [],
                                    blockedIds: [],
                                    joinedAt: DateTime.now(),
                                    isActive: true,
                                  ))
                              .toList(),
                          requirements: selectedRequirements,
                          isActive: true,
                          createdAt: DateTime.now(),
                          createdBy: '', // TODO: Add current user ID
                        );
                        // TODO: Handle game creation
                        Navigator.pop(context, game);
                      }
                    }
                  : null,
              child: const Text('Create Game'),
            ),
          ],
        ),
      ),
    );
  }
}
