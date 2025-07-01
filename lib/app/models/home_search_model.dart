import 'dart:convert';

/// Model representing a community returned by the global search API
class CommunityModel {
  final ProfileImage? profileImage;
  final String id;
  final String userId;
  final String name;
  final String category;
  final bool isTrending;
  final int numberOfMembers;
  final List<Member> members;
  final int numberOfPosts;
  final bool isActive;
  final String status;
  final String? reason;
  final bool isReported;
  final bool isVerified;
  final bool hasLeft;
  final bool hasOpened;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;

  CommunityModel({
    this.profileImage,
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    required this.isTrending,
    required this.numberOfMembers,
    required this.members,
    required this.numberOfPosts,
    required this.isActive,
    required this.status,
    this.reason,
    required this.isReported,
    required this.isVerified,
    required this.hasLeft,
    required this.hasOpened,
    this.createdAt,
    this.updatedAt,
    required this.version,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      profileImage: json['profileImage'] != null
          ? ProfileImage.fromJson(json['profileImage'])
          : null,
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      isTrending: json['isTrending'] ?? false,
      numberOfMembers: json['numberOfMembers'] ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      numberOfPosts: json['numberofPosts'] ?? 0,
      isActive: json['isActive'] ?? false,
      status: json['status'] ?? '',
      reason: json['reason'],
      isReported: json['isReported'] ?? false,
      isVerified: json['isVerified'] ?? false,
      hasLeft: json['hasLeft'] ?? false,
      hasOpened: json['hasOpened'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      version: json['__v'] ?? 0,
    );
  }
}

/// Nested profile image for CommunityModel
class ProfileImage {
  final String url;

  ProfileImage({required this.url});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'] ?? '',
    );
  }
}

/// Member entry in a community
class Member {
  final String userId;
  final bool hasLeft;
  final String id;

  Member({required this.userId, required this.hasLeft, required this.id});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userId: json['userId'] ?? '',
      hasLeft: json['hasLeft'] ?? false,
      id: json['_id'] ?? '',
    );
  }
}

/// Model for `challenges` list in the API
class ChallengeModel {
  final String id;
  final String challengeTitle;
  final String challengeIntro;
  final String status;
  final String category;
  final String type;
  final int totalDuration;
  final int totalXP;
  final bool isActive;
  final int totalKalikoins;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;

  ChallengeModel({
    required this.id,
    required this.challengeTitle,
    required this.challengeIntro,
    required this.status,
    required this.category,
    required this.type,
    required this.totalDuration,
    required this.totalXP,
    required this.isActive,
    required this.totalKalikoins,
    this.createdAt,
    this.updatedAt,
    required this.version,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['_id'] ?? '',
      challengeTitle: json['challengeTitle'] ?? '',
      challengeIntro: json['challengeIntro'] ?? '',
      status: json['status'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      totalDuration: json['totalDuration'] ?? 0,
      totalXP: json['totalXP'] ?? 0,
      isActive: json['isActive'] ?? false,
      totalKalikoins: json['totalKalikoins'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      version: json['__v'] ?? 0,
    );
  }
}

/// Model for `mentalGyms` list in the API
class MentalGymModel {
  final Thumbnail? thumbnail;
  final String id;
  final String title;
  final String description;
  final List<String> category;
  final int totalDuration;
  final bool isActive;
  final bool isTrending;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;

  MentalGymModel({
    this.thumbnail,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.totalDuration,
    required this.isActive,
    required this.isTrending,
    this.createdAt,
    this.updatedAt,
    required this.version,
  });

  factory MentalGymModel.fromJson(Map<String, dynamic> json) {
    return MentalGymModel(
      thumbnail: json['thumbnail'] != null
          ? Thumbnail.fromJson(json['thumbnail'])
          : null,
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      totalDuration: json['totalDuration'] ?? 0,
      isActive: json['isActive'] ?? false,
      isTrending: json['isTrending'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      version: json['__v'] ?? 0,
    );
  }
}

/// Model for a workout returned by the API
class WorkoutModel {
  final Thumbnail? thumbnail;
  final String id;
  final String title;
  final String description;
  final List<String> category;
  var totalDuration;
  final bool isActive;
  final bool isTrending;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;

  WorkoutModel({
    this.thumbnail,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.totalDuration,
    required this.isActive,
    required this.isTrending,
    this.createdAt,
    this.updatedAt,
    required this.version,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      thumbnail: json['thumbnail'] != null
          ? Thumbnail.fromJson(json['thumbnail'])
          : null,
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      totalDuration: json['totalDuration'] ?? 0,
      isActive: json['isActive'] ?? false,
      isTrending: json['isTrending'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      version: json['__v'] ?? 0,
    );
  }
}

/// Nested thumbnail for WorkoutModel
class Thumbnail {
  final String key;
  final String url;

  Thumbnail({required this.key, required this.url});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      key: json['key'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
