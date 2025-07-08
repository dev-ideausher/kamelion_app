import 'dart:convert';

/// Model representing a community returned by the global search API

/// Nested profile image for CommunityModel

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
  final String image;
  final String challengeIntro;
  final String status;
  final List<String> categories;
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
    required this.image,
    required this.challengeIntro,
    required this.status,
    required this.categories,
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
    List<String> parsedCategories = [];
    if (json['category'] is List) {
      parsedCategories =
          List<String>.from(json['category'].map((e) => e.toString()));
    } else if (json['category'] != null) {
      parsedCategories = [json['category'].toString()];
    }
    return ChallengeModel(
      id: json['_id'] ?? '',
      challengeTitle: json['challengeTitle'] ?? '',
      challengeIntro: json['challengeIntro'] ?? '',
      image: json['image'],
      status: json['status'] ?? '',
      categories: parsedCategories,
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
// class MentalGymModel {
//   final Thumbnail? thumbnail;
//   final String id;
//   final String title;
//   final String description;
//   final List<String> category;
//   final int totalDuration;
//   final bool isActive;
//   final bool isTrending;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int version;

//   MentalGymModel({
//     this.thumbnail,
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.category,
//     required this.totalDuration,
//     required this.isActive,
//     required this.isTrending,
//     this.createdAt,
//     this.updatedAt,
//     required this.version,
//   });

//   factory MentalGymModel.fromJson(Map<String, dynamic> json) {
//     return MentalGymModel(
//       thumbnail: json['thumbnail'] != null
//           ? Thumbnail.fromJson(json['thumbnail'])
//           : null,
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       category: (json['category'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//       totalDuration: json['totalDuration'] ?? 0,
//       isActive: json['isActive'] ?? false,
//       isTrending: json['isTrending'] ?? false,
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'])
//           : null,
//       updatedAt: json['updatedAt'] != null
//           ? DateTime.tryParse(json['updatedAt'])
//           : null,
//       version: json['__v'] ?? 0,
//     );
//   }
// }

/// Model for a workout returned by the API
class WorkoutModel {
  final Thumbnail? thumbnail;
  final String id;
  final String title;
  final String description;
  final String mentalGymId;
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
    required this.mentalGymId,
    required this.version,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      thumbnail: json['thumbnail'] != null
          ? Thumbnail.fromJson(json['thumbnail'])
          : null,
      id: json['_id'] ?? '',
      title: json['workoutTitle'] ?? '',
      description: json['description'] ?? '',
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      mentalGymId: json['mentalGym'],
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
