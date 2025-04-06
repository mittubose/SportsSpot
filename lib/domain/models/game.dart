import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final String id;
  final String courtId;
  final DateTime dateTime;
  final String type;
  final int maxPlayers;
  final List<String> playerIds;
  final String skillLevel;
  final String status;
  final String? notes;

  Game({
    required this.id,
    required this.courtId,
    required this.dateTime,
    required this.type,
    required this.maxPlayers,
    required this.playerIds,
    required this.skillLevel,
    required this.status,
    this.notes,
  });

  int get availableSpots => maxPlayers - playerIds.length;
  bool get isFull => availableSpots <= 0;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
