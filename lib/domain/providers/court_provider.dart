import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/repositories/court_repository.dart';

final courtRepositoryProvider = Provider<CourtRepository>((ref) {
  return CourtRepository();
});

final nearbyCourtsProvider = FutureProvider<List<Court>>((ref) async {
  // Simulate API delay
  await Future.delayed(const Duration(seconds: 1));

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Generate some booked slots and public games
  final List<TimeSlot> bookedSlots = [
    TimeSlot(
      id: '1',
      startTime: DateTime(today.year, today.month, today.day, 14), // 2 PM
      endTime: DateTime(today.year, today.month, today.day, 15), // 3 PM
      price: 800,
      isAvailable: false,
      bookingId: 'booking1',
    ),
    TimeSlot(
      id: '2',
      startTime: DateTime(today.year, today.month, today.day, 18), // 6 PM
      endTime: DateTime(today.year, today.month, today.day, 19), // 7 PM
      price: 800,
      isAvailable: false,
      gameId: 'game1',
    ),
  ];

  final publicGames = [
    PublicGame(
      id: 'game1',
      title: 'Friendly Doubles',
      courtId: '1',
      startTime: DateTime(today.year, today.month, today.day, 18), // 6 PM
      endTime: DateTime(today.year, today.month, today.day, 19), // 7 PM
      maxPlayers: 4,
      currentPlayers: 2,
      skillLevel: 'Intermediate',
      gameType: 'Doubles',
      pricePerPlayer: 200,
      playerIds: ['player1', 'player2'],
    ),
    PublicGame(
      id: 'game2',
      title: 'Singles Practice',
      courtId: '1',
      startTime: DateTime(today.year, today.month, today.day, 20), // 8 PM
      endTime: DateTime(today.year, today.month, today.day, 21), // 9 PM
      maxPlayers: 2,
      currentPlayers: 1,
      skillLevel: 'Beginner',
      gameType: 'Singles',
      pricePerPlayer: 400,
      playerIds: ['player3'],
    ),
  ];

  final gameRequirements = [
    GameRequirement(
      bringOwnPaddle: true,
      genderRestriction: 'Men',
      minRating: 4,
      requiredEquipment: ['Paddle', 'Sports Shoes'],
      notes: 'Intermediate level players only',
    ),
    GameRequirement(
      bringOwnPaddle: false,
      minRating: 2,
      requiredEquipment: ['Sports Shoes'],
      notes: 'Beginner friendly, paddles available for rent',
    ),
  ];

  // Return dummy data
  return [
    Court(
      id: '1',
      name: 'Tennis Club A',
      latitude: 12.9716,
      longitude: 77.5946,
      address: '123 Main St, Bangalore',
      rating: 4.5,
      isJoolaVerified: true,
      numberOfCourts: 3,
      photoUrl: null,
      amenities: ['Parking', 'Changing Room', 'Pro Shop'],
      openingHours: '06:00-22:00',
      pricePerHour: 800,
      bookedSlots: bookedSlots,
      publicGames: publicGames,
      gameRequirements: [gameRequirements[0]],
    ),
    Court(
      id: '2',
      name: 'Sports Arena B',
      latitude: 12.9716,
      longitude: 77.5946,
      address: '456 Park Road, Bangalore',
      rating: 4.2,
      isJoolaVerified: true,
      numberOfCourts: 2,
      photoUrl: null,
      amenities: ['Parking', 'Cafe', 'Pro Coach'],
      openingHours: '07:00-21:00',
      pricePerHour: 600,
      bookedSlots: [],
      publicGames: [],
      gameRequirements: [gameRequirements[1]],
    ),
    Court(
      id: '3',
      name: 'Community Court C',
      latitude: 12.9716,
      longitude: 77.5946,
      address: '789 Garden Lane, Bangalore',
      rating: 3.8,
      isJoolaVerified: false,
      numberOfCourts: 1,
      photoUrl: null,
      amenities: ['Parking'],
      openingHours: '08:00-20:00',
      pricePerHour: 400,
      bookedSlots: [],
      publicGames: [],
      gameRequirements: [],
    ),
  ];
});

final selectedCourtProvider = StateProvider<Court?>((ref) => null);

final courtSearchQueryProvider = StateProvider<String>((ref) => '');
