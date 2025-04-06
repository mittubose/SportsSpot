// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatMessage',
      json,
      ($checkedConvert) {
        final val = ChatMessage(
          id: $checkedConvert('id', (v) => v as String),
          senderId: $checkedConvert('sender_id', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String),
          timestamp:
              $checkedConvert('timestamp', (v) => DateTime.parse(v as String)),
          gameId: $checkedConvert('game_id', (v) => v as String?),
          isRead: $checkedConvert('is_read', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'senderId': 'sender_id',
        'gameId': 'game_id',
        'isRead': 'is_read'
      },
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'game_id': instance.gameId,
      'is_read': instance.isRead,
    };
