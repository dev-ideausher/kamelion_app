 // adjust path to your JournalEntry

import 'package:kamelion/app/models/journals_model.dart';

/// Marker interface
abstract class JournalListItem {}

/// A header showing a full‐day label
class DateHeader implements JournalListItem {
  final DateTime date;
  DateHeader(this.date);
}

/// Wraps a real journal entry
class EntryItem implements JournalListItem {
  final JournalEntry entry;
  EntryItem(this.entry);
}