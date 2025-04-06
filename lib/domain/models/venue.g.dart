// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRequirement _$GameRequirementFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GameRequirement',
      json,
      ($checkedConvert) {
        final val = GameRequirement(
          bringOwnPaddle: $checkedConvert('bring_own_paddle', (v) => v as bool),
          genderRestriction:
              $checkedConvert('gender_restriction', (v) => v as String?),
          minRating: $checkedConvert('min_rating', (v) => (v as num).toInt()),
          requiredEquipment: $checkedConvert('required_equipment',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          notes: $checkedConvert('notes', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'bringOwnPaddle': 'bring_own_paddle',
        'genderRestriction': 'gender_restriction',
        'minRating': 'min_rating',
        'requiredEquipment': 'required_equipment'
      },
    );

Map<String, dynamic> _$GameRequirementToJson(GameRequirement instance) =>
    <String, dynamic>{
      'bring_own_paddle': instance.bringOwnPaddle,
      'gender_restriction': instance.genderRestriction,
      'min_rating': instance.minRating,
      'required_equipment': instance.requiredEquipment,
      'notes': instance.notes,
    };

JoinRequest _$JoinRequestFromJson(Map<String, dynamic> json) => $checkedCreate(
      'JoinRequest',
      json,
      ($checkedConvert) {
        final val = JoinRequest(
          id: $checkedConvert('id', (v) => v as String),
          playerId: $checkedConvert('player_id', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => v as String),
          requestedAt: $checkedConvert(
              'requested_at', (v) => DateTime.parse(v as String)),
          status: $checkedConvert('status', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'playerId': 'player_id',
        'gameId': 'game_id',
        'requestedAt': 'requested_at'
      },
    );

Map<String, dynamic> _$JoinRequestToJson(JoinRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player_id': instance.playerId,
      'game_id': instance.gameId,
      'requested_at': instance.requestedAt.toIso8601String(),
      'status': instance.status,
      'message': instance.message,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Booking',
      json,
      ($checkedConvert) {
        final val = Booking(
          id: $checkedConvert('id', (v) => v as String),
          venueId: $checkedConvert('venue_id', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => v as String),
          startTime:
              $checkedConvert('start_time', (v) => DateTime.parse(v as String)),
          endTime:
              $checkedConvert('end_time', (v) => DateTime.parse(v as String)),
          bookedBy: $checkedConvert('booked_by', (v) => v as String),
          bookedAt:
              $checkedConvert('booked_at', (v) => DateTime.parse(v as String)),
          amount: $checkedConvert('amount', (v) => (v as num).toDouble()),
          status: $checkedConvert('status', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'venueId': 'venue_id',
        'gameId': 'game_id',
        'startTime': 'start_time',
        'endTime': 'end_time',
        'bookedBy': 'booked_by',
        'bookedAt': 'booked_at'
      },
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'venue_id': instance.venueId,
      'game_id': instance.gameId,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'booked_by': instance.bookedBy,
      'booked_at': instance.bookedAt.toIso8601String(),
      'amount': instance.amount,
      'status': instance.status,
    };

Venue _$VenueFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Venue',
      json,
      ($checkedConvert) {
        final val = Venue(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          address: $checkedConvert('address', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          description: $checkedConvert('description', (v) => v as String),
          amenities: $checkedConvert('amenities',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          images: $checkedConvert('images',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          courtTypes: $checkedConvert('court_types',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          registeredPlayers: $checkedConvert(
              'registered_players',
              (v) => (v as List<dynamic>)
                  .map((e) => PlayerProfile.fromJson(e as Map<String, dynamic>))
                  .toList()),
          chatMessages: $checkedConvert(
              'chat_messages',
              (v) => (v as List<dynamic>)
                  .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
                  .toList()),
          timeSlots: $checkedConvert(
              'time_slots',
              (v) => (v as List<dynamic>)
                  .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
                  .toList()),
          currentBookings: $checkedConvert(
              'current_bookings',
              (v) => (v as List<dynamic>)
                  .map((e) => Booking.fromJson(e as Map<String, dynamic>))
                  .toList()),
          publicGameIds: $checkedConvert('public_game_ids',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          photoUrl: $checkedConvert('photo_url', (v) => v as String?),
          rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
          totalRatings:
              $checkedConvert('total_ratings', (v) => (v as num).toInt()),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          pendingRequests: $checkedConvert(
              'pending_requests',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          JoinRequest.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          gameRequirements: $checkedConvert(
              'game_requirements',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          GameRequirement.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          courts: $checkedConvert(
              'courts',
              (v) => (v as List<dynamic>)
                  .map((e) => Court.fromJson(e as Map<String, dynamic>))
                  .toList()),
          availableSlots: $checkedConvert(
              'available_slots',
              (v) => (v as List<dynamic>)
                  .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'courtTypes': 'court_types',
        'registeredPlayers': 'registered_players',
        'chatMessages': 'chat_messages',
        'timeSlots': 'time_slots',
        'currentBookings': 'current_bookings',
        'publicGameIds': 'public_game_ids',
        'photoUrl': 'photo_url',
        'totalRatings': 'total_ratings',
        'isActive': 'is_active',
        'createdAt': 'created_at',
        'pendingRequests': 'pending_requests',
        'gameRequirements': 'game_requirements',
        'availableSlots': 'available_slots'
      },
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'amenities': instance.amenities,
      'images': instance.images,
      'court_types': instance.courtTypes,
      'registered_players':
          instance.registeredPlayers.map((e) => e.toJson()).toList(),
      'chat_messages': instance.chatMessages.map((e) => e.toJson()).toList(),
      'time_slots': instance.timeSlots.map((e) => e.toJson()).toList(),
      'current_bookings':
          instance.currentBookings.map((e) => e.toJson()).toList(),
      'public_game_ids': instance.publicGameIds,
      'photo_url': instance.photoUrl,
      'rating': instance.rating,
      'total_ratings': instance.totalRatings,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'pending_requests':
          instance.pendingRequests.map((e) => e.toJson()).toList(),
      'game_requirements':
          instance.gameRequirements.map((e) => e.toJson()).toList(),
      'courts': instance.courts.map((e) => e.toJson()).toList(),
      'available_slots':
          instance.availableSlots.map((e) => e.toJson()).toList(),
    };
