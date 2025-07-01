import 'package:intl/intl.dart';

class MoodEntry {
  final String id;
  final String userId;
  final String mood;
  final String? note;
  final List<String>? feelings;
  final String? activities;
  final DateTime createdAt;

  MoodEntry({
    required this.id,
    required this.userId,
    required this.mood,
    this.note,
    this.feelings,
    this.activities,
    required this.createdAt,
  });

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      mood: json['mood'] as String,
      note: json['note'] as String?,
      feelings: (json['feelings'] as List<dynamic>?)
          ?.map((e) => (e as String).trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      activities: json['activities'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
    );
  }

  /// helper to format time like "08:00 AM"
  String get formattedTime => DateFormat('hh:mm a').format(createdAt);
}
