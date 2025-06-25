class MoodModel {
  String? sId;
  String? userId;
  String? mood;
  String? note;
  List<String>? feelings;
  String? activities;
  String? createdAt;
  String? updatedAt;
  String? createdAtLocal;
  int? iV;

  MoodModel({
    this.sId,
    this.userId,
    this.mood,
    this.note,
    this.feelings,
    this.activities,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.createdAtLocal,
  });

  MoodModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    mood = json['mood'];
    note = json['note'];
    feelings = json['feelings'].cast<String>();
    activities = json['activities'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    createdAtLocal = json['createdAtLocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['mood'] = this.mood;
    data['note'] = this.note;
    data['feelings'] = this.feelings;
    data['activities'] = this.activities;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['createdAtLocal'] = this.createdAtLocal;
    return data;
  }
}
