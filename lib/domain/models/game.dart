import 'package:json_annotation/json_annotation.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/models/chat.dart';

part 'game.g.dart';

enum GameType { casual, pro, tournament, training }

enum GamePrivacy { public, private }

enum SkillLevel { beginner, intermediate, advanced, pro }

@JsonSerializable()
class Game {
  final String id;
  final String title;
  final DateTime dateTime;
  final int playerCount;
  final GamePrivacy privacy;
  final GameType gameType;
  final SkillLevel skillLevel;
  final Venue venue;
  final List<Player> players;
  final List<String> requirements;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  final String createdBy;
  final String? chatGroupId;

  Game({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.playerCount,
    required this.privacy,
    required this.gameType,
    required this.skillLevel,
    required this.venue,
    required this.players,
    required this.requirements,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
    this.chatGroupId,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  Game copyWith({
    String? id,
    String? title,
    DateTime? dateTime,
    int? playerCount,
    GamePrivacy? privacy,
    GameType? gameType,
    SkillLevel? skillLevel,
    Venue? venue,
    List<Player>? players,
    List<String>? requirements,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    String? createdBy,
    String? chatGroupId,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      playerCount: playerCount ?? this.playerCount,
      privacy: privacy ?? this.privacy,
      gameType: gameType ?? this.gameType,
      skillLevel: skillLevel ?? this.skillLevel,
      venue: venue ?? this.venue,
      players: players ?? this.players,
      requirements: requirements ?? this.requirements,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      chatGroupId: chatGroupId ?? this.chatGroupId,
    );
  }
}

@JsonSerializable()
class PublicGame {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int maxPlayers;
  final int currentPlayers;
  final GameType gameType;
  final SkillLevel skillLevel;
  final double pricePerPlayer;
  final List<String> requirements;
  final List<String> playerIds;
  final String courtId;
  final List<PlayerProfile> playerProfiles;
  final List<ChatMessage> chatMessages;

  PublicGame({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.gameType,
    required this.skillLevel,
    required this.pricePerPlayer,
    required this.requirements,
    required this.playerIds,
    required this.courtId,
    required this.playerProfiles,
    required this.chatMessages,
  });

  factory PublicGame.fromJson(Map<String, dynamic> json) =>
      _$PublicGameFromJson(json);
  Map<String, dynamic> toJson() => _$PublicGameToJson(this);

  PublicGame copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    int? maxPlayers,
    int? currentPlayers,
    GameType? gameType,
    SkillLevel? skillLevel,
    double? pricePerPlayer,
    List<String>? requirements,
    List<String>? playerIds,
    String? courtId,
    List<PlayerProfile>? playerProfiles,
    List<ChatMessage>? chatMessages,
  }) {
    return PublicGame(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      currentPlayers: currentPlayers ?? this.currentPlayers,
      gameType: gameType ?? this.gameType,
      skillLevel: skillLevel ?? this.skillLevel,
      pricePerPlayer: pricePerPlayer ?? this.pricePerPlayer,
      requirements: requirements ?? this.requirements,
      playerIds: playerIds ?? this.playerIds,
      courtId: courtId ?? this.courtId,
      playerProfiles: playerProfiles ?? this.playerProfiles,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}
