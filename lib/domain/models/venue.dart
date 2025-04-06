import 'package:json_annotation/json_annotation.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/chat.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/court.dart';

part 'venue.g.dart';

@JsonSerializable()
class GameRequirement {
  final bool bringOwnPaddle;
  final String? genderRestriction;
  final int minRating;
  final List<String> requiredEquipment;
  final String? notes;

  GameRequirement({
    required this.bringOwnPaddle,
    this.genderRestriction,
    required this.minRating,
    required this.requiredEquipment,
    this.notes,
  });

  factory GameRequirement.fromJson(Map<String, dynamic> json) =>
      _$GameRequirementFromJson(json);
  Map<String, dynamic> toJson() => _$GameRequirementToJson(this);
}

@JsonSerializable()
class JoinRequest {
  final String id;
  final String playerId;
  final String gameId;
  final DateTime requestedAt;
  final String status; // pending, accepted, rejected
  final String? message;

  JoinRequest({
    required this.id,
    required this.playerId,
    required this.gameId,
    required this.requestedAt,
    required this.status,
    this.message,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestFromJson(json);
  Map<String, dynamic> toJson() => _$JoinRequestToJson(this);
}

@JsonSerializable()
class Booking {
  final String id;
  final String venueId;
  final String gameId;
  final DateTime startTime;
  final DateTime endTime;
  final String bookedBy;
  final DateTime bookedAt;
  final double amount;
  final String status;

  Booking({
    required this.id,
    required this.venueId,
    required this.gameId,
    required this.startTime,
    required this.endTime,
    required this.bookedBy,
    required this.bookedAt,
    required this.amount,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable()
class Venue {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> amenities;
  final List<String> images;
  final List<String> courtTypes;
  final List<PlayerProfile> registeredPlayers;
  final List<ChatMessage> chatMessages;
  final List<TimeSlot> timeSlots;
  final List<Booking> currentBookings;
  final List<String> publicGameIds;
  final String? photoUrl;
  final double rating;
  final int totalRatings;
  final bool isActive;
  final DateTime createdAt;
  final List<JoinRequest> pendingRequests;
  final List<GameRequirement> gameRequirements;
  @JsonKey(defaultValue: <Court>[])
  final List<Court> courts;
  @JsonKey(defaultValue: <TimeSlot>[])
  final List<TimeSlot> availableSlots;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.amenities,
    required this.images,
    required this.courtTypes,
    required this.registeredPlayers,
    required this.chatMessages,
    required this.timeSlots,
    required this.currentBookings,
    required this.publicGameIds,
    this.photoUrl,
    required this.rating,
    required this.totalRatings,
    required this.isActive,
    required this.createdAt,
    this.pendingRequests = const [],
    this.gameRequirements = const [],
    this.courts = const [],
    this.availableSlots = const [],
  });

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  List<TimeSlot> getAvailableSlots(DateTime date) {
    return timeSlots
        .where((slot) =>
            slot.isAvailable &&
            slot.startTime.year == date.year &&
            slot.startTime.month == date.month &&
            slot.startTime.day == date.day)
        .toList();
  }

  List<JoinRequest> getPendingRequestsForGame(String gameId) {
    return pendingRequests
        .where((request) =>
            request.gameId == gameId && request.status == 'pending')
        .toList();
  }

  List<ChatMessage> getChatMessagesForGame(String gameId) {
    return chatMessages.where((message) => message.gameId == gameId).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  List<PlayerProfile> getPlayersForGame(String gameId) {
    final booking =
        currentBookings.firstWhere((booking) => booking.gameId == gameId);
    return registeredPlayers
        .where((player) => booking.bookedBy == player.id)
        .toList();
  }

  Venue copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? description,
    List<String>? amenities,
    List<String>? images,
    List<String>? courtTypes,
    List<PlayerProfile>? registeredPlayers,
    List<ChatMessage>? chatMessages,
    List<TimeSlot>? timeSlots,
    List<Booking>? currentBookings,
    List<String>? publicGameIds,
    String? photoUrl,
    double? rating,
    int? totalRatings,
    bool? isActive,
    DateTime? createdAt,
    List<JoinRequest>? pendingRequests,
    List<GameRequirement>? gameRequirements,
    List<Court>? courts,
    List<TimeSlot>? availableSlots,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      amenities: amenities ?? this.amenities,
      images: images ?? this.images,
      courtTypes: courtTypes ?? this.courtTypes,
      registeredPlayers: registeredPlayers ?? this.registeredPlayers,
      chatMessages: chatMessages ?? this.chatMessages,
      timeSlots: timeSlots ?? this.timeSlots,
      currentBookings: currentBookings ?? this.currentBookings,
      publicGameIds: publicGameIds ?? this.publicGameIds,
      photoUrl: photoUrl ?? this.photoUrl,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      gameRequirements: gameRequirements ?? this.gameRequirements,
      courts: courts ?? this.courts,
      availableSlots: availableSlots ?? this.availableSlots,
    );
  }
}
