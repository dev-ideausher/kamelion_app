class MyStatsModel {
  int? totalCompletedQuizzes;
  int? totalMoodEntries;
  int? totalJournalEntries;
  int? totalPostWords;

  MyStatsModel(
      {this.totalCompletedQuizzes,
      this.totalMoodEntries,
      this.totalJournalEntries,
      this.totalPostWords});

  MyStatsModel.fromJson(Map<String, dynamic> json) {
    totalCompletedQuizzes = json['totalCompletedQuizzes'];
    totalMoodEntries = json['totalMoodEntries'];
    totalJournalEntries = json['totalJournalEntries'];
    totalPostWords = json['totalPostWords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCompletedQuizzes'] = this.totalCompletedQuizzes;
    data['totalMoodEntries'] = this.totalMoodEntries;
    data['totalJournalEntries'] = this.totalJournalEntries;
    data['totalPostWords'] = this.totalPostWords;
    return data;
  }
}
