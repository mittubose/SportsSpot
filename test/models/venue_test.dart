import 'package:flutter_test/flutter_test.dart';
import 'package:joola_spot/domain/models/venue.dart';

void main() {
  group('Venue Model Tests', () {
    late Venue venue;
    late PlayerProfile player1;
    late PlayerProfile player2;
    late GameRequirement requirement;
    late JoinRequest request;
    late ChatMessage message;
    late Booking booking;

    setUp(() {
      player1 = PlayerProfile(
        id: 'player1',
        name: 'John Doe',
        gender: 'male',
        rating: 4.5,
        preferredGameTypes: ['Singles', 'Doubles'],
        achievements: ['Tournament Winner 2023'],
        joinedDate: DateTime(2023),
      );

      player2 = PlayerProfile(
        id: 'player2',
        name: 'Jane Smith',
        gender: 'female',
        rating: 4.2,
        preferredGameTypes: ['Doubles'],
        achievements: [],
        joinedDate: DateTime(2023),
      );

      requirement = GameRequirement(
        bringOwnPaddle: true,
        genderRestriction: 'male',
        minRating: 4,
        requiredEquipment: ['Paddle', 'Sports Shoes'],
        notes: 'Intermediate level players only',
      );

      request = JoinRequest(
        id: 'request1',
        playerId: player2.id,
        gameId: 'game1',
        requestedAt: DateTime(2024),
        status: 'pending',
        message: 'Would love to join!',
      );

      message = ChatMessage(
        id: 'msg1',
        senderId: player1.id,
        gameId: 'game1',
        message: 'Hello everyone!',
        sentAt: DateTime(2024),
        isRead: false,
      );

      booking = Booking(
        id: 'booking1',
        venueId: 'venue1',
        gameId: 'game1',
        startTime: DateTime(2024),
        endTime: DateTime(2024).add(const Duration(hours: 1)),
        bookedBy: player1.id,
        bookedAt: DateTime(2024),
        amount: 800,
        status: 'confirmed',
      );

      venue = Venue(
        id: 'venue1',
        name: 'Test Venue',
        address: '123 Test St',
        latitude: 12.9716,
        longitude: 77.5946,
        amenities: ['Parking', 'Pro Shop'],
        timeSlots: [],
        currentBookings: [booking],
        publicGameIds: ['game1'],
        rating: 4.5,
        totalRatings: 10,
        isActive: true,
        createdAt: DateTime(2024),
        registeredPlayers: [player1, player2],
        pendingRequests: [request],
        gameChats: [message],
        gameRequirements: [requirement],
      );
    });

    test('getPendingRequestsForGame returns correct requests', () {
      final requests = venue.getPendingRequestsForGame('game1');
      expect(requests.length, 1);
      expect(requests.first.id, 'request1');
      expect(requests.first.status, 'pending');
    });

    test('getChatMessagesForGame returns sorted messages', () {
      final messages = venue.getChatMessagesForGame('game1');
      expect(messages.length, 1);
      expect(messages.first.id, 'msg1');
      expect(messages.first.senderId, player1.id);
    });

    test('getPlayersForGame returns correct players', () {
      final players = venue.getPlayersForGame('game1');
      expect(players.length, 1);
      expect(players.first.id, player1.id);
    });

    test('copyWith creates a new instance with updated values', () {
      final newRequirement = GameRequirement(
        bringOwnPaddle: false,
        minRating: 3,
        requiredEquipment: ['Sports Shoes'],
      );

      final updatedVenue = venue.copyWith(
        name: 'Updated Venue',
        gameRequirements: [newRequirement],
      );

      expect(updatedVenue.name, 'Updated Venue');
      expect(updatedVenue.gameRequirements.length, 1);
      expect(updatedVenue.gameRequirements.first.bringOwnPaddle, false);
      expect(updatedVenue.id, venue.id);
    });
  });
}
