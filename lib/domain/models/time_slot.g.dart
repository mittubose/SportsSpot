// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TimeSlot',
      json,
      ($checkedConvert) {
        final val = TimeSlot(
          id: $checkedConvert('id', (v) => v as String),
          startTime:
              $checkedConvert('start_time', (v) => DateTime.parse(v as String)),
          endTime:
              $checkedConvert('end_time', (v) => DateTime.parse(v as String)),
          price: $checkedConvert('price', (v) => (v as num).toDouble()),
          isAvailable: $checkedConvert('is_available', (v) => v as bool),
          bookingId: $checkedConvert('booking_id', (v) => v as String?),
          gameId: $checkedConvert('game_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'startTime': 'start_time',
        'endTime': 'end_time',
        'isAvailable': 'is_available',
        'bookingId': 'booking_id',
        'gameId': 'game_id'
      },
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'id': instance.id,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'price': instance.price,
      'is_available': instance.isAvailable,
      'booking_id': instance.bookingId,
      'game_id': instance.gameId,
    };
