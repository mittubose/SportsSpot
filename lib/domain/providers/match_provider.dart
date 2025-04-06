import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/game.dart';
import 'package:joola_spot/domain/models/venue.dart';

// Filter providers
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final selectedGameTypeProvider = StateProvider<GameType?>((ref) => null);
final selectedSkillLevelProvider = StateProvider<SkillLevel?>((ref) => null);

final publicMatchesProvider =
    FutureProvider.family<List<Game>, DateTime>((ref, date) async {
  // TODO: Implement API call to fetch public matches for the given date
  await Future.delayed(const Duration(seconds: 1)); // Simulate API call
  return [];
});

final venueAvailabilityProvider =
    FutureProvider.family<List<Venue>, DateTime>((ref, date) async {
  // TODO: Implement API call to fetch venue availability for the given date
  await Future.delayed(const Duration(seconds: 1)); // Simulate API call
  return [];
});
