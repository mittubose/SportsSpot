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
};

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'beginner',
  SkillLevel.intermediate: 'intermediate',
  SkillLevel.pro: 'pro',
};
