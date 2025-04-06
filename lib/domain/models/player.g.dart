// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Rating',
      json,
      ($checkedConvert) {
        final val = Rating(
          id: $checkedConvert('id', (v) => v as String),
          category: $checkedConvert('category', (v) => v as String),
          score: $checkedConvert('score', (v) => (v as num).toDouble()),
          comment: $checkedConvert('comment', (v) => v as String?),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
          ratedBy: $checkedConvert('rated_by', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'ratedBy': 'rated_by'},
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'score': instance.score,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
      'rated_by': instance.ratedBy,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Badge',
      json,
      ($checkedConvert) {
        final val = Badge(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Player',
      json,
      ($checkedConvert) {
        final val = Player(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          photoUrl: $checkedConvert('photo_url', (v) => v as String?),
          privacy: $checkedConvert(
              'privacy', (v) => $enumDecode(_$PlayerPrivacyEnumMap, v)),
          ratings: $checkedConvert(
              'ratings',
              (v) => (v as List<dynamic>)
                  .map((e) => Rating.fromJson(e as Map<String, dynamic>))
                  .toList()),
          badges: $checkedConvert(
              'badges',
              (v) => (v as List<dynamic>)
                  .map((e) => Badge.fromJson(e as Map<String, dynamic>))
                  .toList()),
          friendIds: $checkedConvert('friend_ids',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          blockedIds: $checkedConvert('blocked_ids',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          joinedAt:
              $checkedConvert('joined_at', (v) => DateTime.parse(v as String)),
          isActive: $checkedConvert('is_active', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'photoUrl': 'photo_url',
        'friendIds': 'friend_ids',
        'blockedIds': 'blocked_ids',
        'phoneNumber': 'phone_number',
        'joinedAt': 'joined_at',
        'isActive': 'is_active'
      },
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'privacy': _$PlayerPrivacyEnumMap[instance.privacy]!,
      'ratings': instance.ratings.map((e) => e.toJson()).toList(),
      'badges': instance.badges.map((e) => e.toJson()).toList(),
      'friend_ids': instance.friendIds,
      'blocked_ids': instance.blockedIds,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'joined_at': instance.joinedAt.toIso8601String(),
      'is_active': instance.isActive,
    };

const _$PlayerPrivacyEnumMap = {
  PlayerPrivacy.public: 'public',
  PlayerPrivacy.anonymous: 'anonymous',
};

PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PlayerProfile',
      json,
      ($checkedConvert) {
        final val = PlayerProfile(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          rating: $checkedConvert('rating', (v) => (v as num).toDouble()),
          gamesPlayed:
              $checkedConvert('games_played', (v) => (v as num).toInt()),
          profilePicUrl:
              $checkedConvert('profile_pic_url', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'gamesPlayed': 'games_played',
        'profilePicUrl': 'profile_pic_url'
      },
    );

Map<String, dynamic> _$PlayerProfileToJson(PlayerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'games_played': instance.gamesPlayed,
      'profile_pic_url': instance.profilePicUrl,
    };
