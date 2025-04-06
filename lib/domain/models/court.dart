import 'package:json_annotation/json_annotation.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';

part 'court.g.dart';

@JsonSerializable()
class Court {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final double rating;
  final bool isJoolaVerified;
  final int numberOfCourts;
  final String? photoUrl;
  final double? distance;
  final List<String> amenities;
  final String openingHours;
  final double pricePerHour;
  final List<TimeSlot> bookedSlots;
  final List<PublicGame> publicGames;
  final List<GameRequirement> gameRequirements;

  Court({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.rating,
    required this.isJoolaVerified,
    required this.numberOfCourts,
    this.photoUrl,
    this.distance,
    required this.amenities,
    required this.openingHours,
    required this.pricePerHour,
    this.bookedSlots = const [],
    this.publicGames = const [],
    this.gameRequirements = const [],
  });

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
  Map<String, dynamic> toJson() => _$CourtToJson(this);
}

@JsonSerializable()
class PublicGame {
  final String id;
  final String title;
  final String courtId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxPlayers;
  final int currentPlayers;
  final String skillLevel;
  final String gameType;
  final double pricePerPlayer;
  final List<String> playerIds;

  PublicGame({
    required this.id,
    required this.title,
    required this.courtId,
    required this.startTime,
    required this.endTime,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.skillLevel,
    required this.gameType,
    required this.pricePerPlayer,
    required this.playerIds,
  });

  factory PublicGame.fromJson(Map<String, dynamic> json) =>
      _$PublicGameFromJson(json);
  Map<String, dynamic> toJson() => _$PublicGameToJson(this);
}
