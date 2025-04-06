// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Court _$CourtFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Court',
      json,
      ($checkedConvert) {
        final val = Court(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          address: $checkedConvert('address', (v) => v as String),
          rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
          isJoolaVerified:
              $checkedConvert('is_joola_verified', (v) => v as bool),
          numberOfCourts:
              $checkedConvert('number_of_courts', (v) => (v as num).toInt()),
          photoUrl: $checkedConvert('photo_url', (v) => v as String?),
          distance: $checkedConvert('distance', (v) => (v as num?)?.toDouble()),
          amenities: $checkedConvert('amenities',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          openingHours: $checkedConvert('opening_hours', (v) => v as String),
          pricePerHour:
              $checkedConvert('price_per_hour', (v) => (v as num).toDouble()),
          bookedSlots: $checkedConvert(
              'booked_slots',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  []),
          publicGames: $checkedConvert(
              'public_games',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => PublicGame.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  []),
          gameRequirements: $checkedConvert(
              'game_requirements',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          GameRequirement.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  []),
        );
        return val;
      },
      fieldKeyMap: const {
        'isJoolaVerified': 'is_joola_verified',
        'numberOfCourts': 'number_of_courts',
        'photoUrl': 'photo_url',
        'openingHours': 'opening_hours',
        'pricePerHour': 'price_per_hour',
        'bookedSlots': 'booked_slots',
        'publicGames': 'public_games',
        'gameRequirements': 'game_requirements'
      },
    );

Map<String, dynamic> _$CourtToJson(Court instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'rating': instance.rating,
      'is_joola_verified': instance.isJoolaVerified,
      'number_of_courts': instance.numberOfCourts,
      'photo_url': instance.photoUrl,
      'distance': instance.distance,
      'amenities': instance.amenities,
      'opening_hours': instance.openingHours,
      'price_per_hour': instance.pricePerHour,
      'booked_slots': instance.bookedSlots.map((e) => e.toJson()).toList(),
      'public_games': instance.publicGames.map((e) => e.toJson()).toList(),
      'game_requirements':
          instance.gameRequirements.map((e) => e.toJson()).toList(),
    };

PublicGame _$PublicGameFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PublicGame',
      json,
      ($checkedConvert) {
        final val = PublicGame(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          courtId: $checkedConvert('court_id', (v) => v as String),
          startTime:
              $checkedConvert('start_time', (v) => DateTime.parse(v as String)),
          endTime:
              $checkedConvert('end_time', (v) => DateTime.parse(v as String)),
          maxPlayers: $checkedConvert('max_players', (v) => (v as num).toInt()),
          currentPlayers:
              $checkedConvert('current_players', (v) => (v as num).toInt()),
          skillLevel: $checkedConvert('skill_level', (v) => v as String),
          gameType: $checkedConvert('game_type', (v) => v as String),
          pricePerPlayer:
              $checkedConvert('price_per_player', (v) => (v as num).toDouble()),
          playerIds: $checkedConvert('player_ids',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'courtId': 'court_id',
        'startTime': 'start_time',
        'endTime': 'end_time',
        'maxPlayers': 'max_players',
        'currentPlayers': 'current_players',
        'skillLevel': 'skill_level',
        'gameType': 'game_type',
        'pricePerPlayer': 'price_per_player',
        'playerIds': 'player_ids'
      },
    );

Map<String, dynamic> _$PublicGameToJson(PublicGame instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'court_id': instance.courtId,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'max_players': instance.maxPlayers,
      'current_players': instance.currentPlayers,
      'skill_level': instance.skillLevel,
      'game_type': instance.gameType,
      'price_per_player': instance.pricePerPlayer,
      'player_ids': instance.playerIds,
    };
