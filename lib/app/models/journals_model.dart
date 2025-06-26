import 'package:intl/intl.dart';

class JournalEntry {
  final String id;
  final String title;
  final String description;
  final String emotion;
  final String feelings;
  final String activities;
  final String time;
  final DateTime createdAt;

  JournalEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.emotion,
    required this.feelings,
    required this.activities,
    required this.time,
    required this.createdAt,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['createdAt']);
    final utcDate = DateTime.parse(json['createdAt'] as String);
    final localDate = utcDate.toLocal();
    return JournalEntry(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      emotion: json['emotion'],
      feelings: json['feelings'],
      activities: json['activities'],
      time: DateFormat('HH:mm').format(createdAt), // Format time as needed
      createdAt: localDate,
    );
  }
  String get formattedTime => DateFormat.jm().format(createdAt);
  // For backward compatibility with existing code
  String get mood => emotion;
}