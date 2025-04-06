// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Game',
      json,
      ($checkedConvert) {
        final val = Game(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          dateTime:
              $checkedConvert('date_time', (v) => DateTime.parse(v as String)),
          playerCount:
              $checkedConvert('player_count', (v) => (v as num).toInt()),
          privacy: $checkedConvert(
              'privacy', (v) => $enumDecode(_$GamePrivacyEnumMap, v)),
          gameType: $checkedConvert(
              'game_type', (v) => $enumDecode(_$GameTypeEnumMap, v)),
          skillLevel: $checkedConvert(
              'skill_level', (v) => $enumDecode(_$SkillLevelEnumMap, v)),
          venue: $checkedConvert(
              'venue', (v) => Venue.fromJson(v as Map<String, dynamic>)),
          players: $checkedConvert(
              'players',
              (v) => (v as List<dynamic>)
                  .map((e) => Player.fromJson(e as Map<String, dynamic>))
                  .toList()),
          requirements: $checkedConvert('requirements',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          description: $checkedConvert('description', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          chatGroupId: $checkedConvert('chat_group_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateTime': 'date_time',
        'playerCount': 'player_count',
        'gameType': 'game_type',
        'skillLevel': 'skill_level',
        'isActive': 'is_active',
        'createdAt': 'created_at',
        'createdBy': 'created_by',
        'chatGroupId': 'chat_group_id'
      },
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date_time': instance.dateTime.toIso8601String(),
      'player_count': instance.playerCount,
      'privacy': _$GamePrivacyEnumMap[instance.privacy]!,
      'game_type': _$GameTypeEnumMap[instance.gameType]!,
      'skill_level': _$SkillLevelEnumMap[instance.skillLevel]!,
      'venue': instance.venue.toJson(),
      'players': instance.players.map((e) => e.toJson()).toList(),
      'requirements': instance.requirements,
      'description': instance.description,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'chat_group_id': instance.chatGroupId,
    };

const _$GamePrivacyEnumMap = {
  GamePrivacy.public: 'public',
  GamePrivacy.private: 'private',
};

const _$GameTypeEnumMap = {
  GameType.casual: 'casual',
  GameType.pro: 'pro',
  GameType.tournament: 'tournament',
  GameType.training: 'training',
};

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'beginner',
  SkillLevel.intermediate: 'intermediate',
  SkillLevel.advanced: 'advanced',
  SkillLevel.pro: 'pro',
};

PublicGame _$PublicGameFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PublicGame',
      json,
      ($checkedConvert) {
        final val = PublicGame(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          startTime:
              $checkedConvert('start_time', (v) => DateTime.parse(v as String)),
          endTime:
              $checkedConvert('end_time', (v) => DateTime.parse(v as String)),
          maxPlayers: $checkedConvert('max_players', (v) => (v as num).toInt()),
          currentPlayers:
              $checkedConvert('current_players', (v) => (v as num).toInt()),
          gameType: $checkedConvert(
              'game_type', (v) => $enumDecode(_$GameTypeEnumMap, v)),
          skillLevel: $checkedConvert(
              'skill_level', (v) => $enumDecode(_$SkillLevelEnumMap, v)),
          pricePerPlayer:
              $checkedConvert('price_per_player', (v) => (v as num).toDouble()),
          requirements: $checkedConvert('requirements',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          playerIds: $checkedConvert('player_ids',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          courtId: $checkedConvert('court_id', (v) => v as String),
          playerProfiles: $checkedConvert(
              'player_profiles',
              (v) => (v as List<dynamic>)
                  .map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>))
                  .toList()),
          chatMessages: $checkedConvert(
              'chat_messages',
              (v) => (v as List<dynamic>)
                  .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'startTime': 'start_time',
        'endTime': 'end_time',
        'maxPlayers': 'max_players',
        'currentPlayers': 'current_players',
        'gameType': 'game_type',
        'skillLevel': 'skill_level',
        'pricePerPlayer': 'price_per_player',
        'playerIds': 'player_ids',
        'courtId': 'court_id',
        'playerProfiles': 'player_profiles',
        'chatMessages': 'chat_messages'
      },
    );

Map<String, dynamic> _$PublicGameToJson(PublicGame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'max_players': instance.maxPlayers,
      'current_players': instance.currentPlayers,
      'game_type': _$GameTypeEnumMap[instance.gameType]!,
      'skill_level': _$SkillLevelEnumMap[instance.skillLevel]!,
      'price_per_player': instance.pricePerPlayer,
      'requirements': instance.requirements,
      'player_ids': instance.playerIds,
      'court_id': instance.courtId,
      'player_profiles':
          instance.playerProfiles.map((e) => e.toJson()).toList(),
      'chat_messages': instance.chatMessages.map((e) => e.toJson()).toList(),
    };
