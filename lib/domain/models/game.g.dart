// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as String,
      courtId: json['courtId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: json['type'] as String,
      maxPlayers: (json['maxPlayers'] as num).toInt(),
      playerIds:
          (json['playerIds'] as List<dynamic>).map((e) => e as String).toList(),
      skillLevel: json['skillLevel'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'courtId': instance.courtId,
      'dateTime': instance.dateTime.toIso8601String(),
      'type': instance.type,
      'maxPlayers': instance.maxPlayers,
      'playerIds': instance.playerIds,
      'skillLevel': instance.skillLevel,
      'status': instance.status,
      'notes': instance.notes,
    };
