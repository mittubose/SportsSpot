// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Court _$CourtFromJson(Map<String, dynamic> json) => Court(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      isJoolaVerified: json['isJoolaVerified'] as bool,
      numberOfCourts: (json['numberOfCourts'] as num).toInt(),
      photoUrl: json['photoUrl'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      amenities:
          (json['amenities'] as List<dynamic>).map((e) => e as String).toList(),
      openingHours: json['openingHours'] as String,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
    );

Map<String, dynamic> _$CourtToJson(Court instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'rating': instance.rating,
      'isJoolaVerified': instance.isJoolaVerified,
      'numberOfCourts': instance.numberOfCourts,
      'photoUrl': instance.photoUrl,
      'distance': instance.distance,
      'amenities': instance.amenities,
      'openingHours': instance.openingHours,
      'pricePerHour': instance.pricePerHour,
    };
