import 'package:json_annotation/json_annotation.dart';

part 'time_slot.g.dart';

@JsonSerializable()
class TimeSlot {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final double price;
  final bool isAvailable;
  final String? bookingId;
  final String? gameId;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.isAvailable,
    this.bookingId,
    this.gameId,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);

  TimeSlot copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    double? price,
    bool? isAvailable,
    String? bookingId,
    String? gameId,
  }) {
    return TimeSlot(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      bookingId: bookingId ?? this.bookingId,
      gameId: gameId ?? this.gameId,
    );
  }
}
