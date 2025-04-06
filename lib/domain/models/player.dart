import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

enum PlayerPrivacy { public, anonymous }

@JsonSerializable()
class Rating {
  final String id;
  final String category;
  final double score;
  final String? comment;
  final DateTime date;
  final String ratedBy;

  Rating({
    required this.id,
    required this.category,
    required this.score,
    this.comment,
    required this.date,
    required this.ratedBy,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable()
class Badge {
  final String id;
  final String type;
  final String name;
  final String description;
  final DateTime earnedAt;

  Badge({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.earnedAt,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}

@JsonSerializable()
class Player {
  final String id;
  final String name;
  final String? photoUrl;
  final PlayerPrivacy privacy;
  final List<Rating> ratings;
  final List<Badge> badges;
  final List<String> friendIds;
  final List<String> blockedIds;
  final String? phoneNumber;
  final String? email;
  final DateTime joinedAt;
  final bool isActive;

  Player({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.privacy,
    required this.ratings,
    required this.badges,
    required this.friendIds,
    required this.blockedIds,
    this.phoneNumber,
    this.email,
    required this.joinedAt,
    required this.isActive,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  double get averageRating {
    if (ratings.isEmpty) return 0.0;
    return ratings.map((r) => r.score).reduce((a, b) => a + b) / ratings.length;
  }

  Player copyWith({
    String? id,
    String? name,
    String? photoUrl,
    PlayerPrivacy? privacy,
    List<Rating>? ratings,
    List<Badge>? badges,
    List<String>? friendIds,
    List<String>? blockedIds,
    String? phoneNumber,
    String? email,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      privacy: privacy ?? this.privacy,
      ratings: ratings ?? this.ratings,
      badges: badges ?? this.badges,
      friendIds: friendIds ?? this.friendIds,
      blockedIds: blockedIds ?? this.blockedIds,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
