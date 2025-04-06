import 'package:json_annotation/json_annotation.dart';

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
  });

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
  Map<String, dynamic> toJson() => _$CourtToJson(this);
}
