class ChallengeDetailsModel {
  String? sId;
  String? challengeTitle;
  String? challengeIntro;
  String? status;
  List<Category>? category;
  String? type;
  int? totalDuration;
  int? totalXP;
  bool? isActive;
  int? totalKalikoins;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;
  bool? isSaved;
  String? startedDate;
  num? progress;
  bool? isJoined;

  ChallengeDetailsModel(
      {this.sId,
      this.challengeTitle,
      this.isJoined,
      this.challengeIntro,
      this.progress,
      this.startedDate,
      this.status,
      this.category,
      this.type,
      this.isSaved,
      this.totalDuration,
      this.totalXP,
      this.isActive,
      this.totalKalikoins,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image});

  ChallengeDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    challengeTitle = json['challengeTitle'];
    challengeIntro = json['challengeIntro'];
    startedDate = json['userChallengeProgress'] == null
        ? DateTime.now().toString()
        : json['userChallengeProgress']['createdAt'];
    status = json['status'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    isSaved = json['isSaved'];
    isJoined = json['isJoined'];
    type = json['type'];
    totalDuration = json['totalDuration'];
    totalXP = json['totalXP'];
    isActive = json['isActive'];
    totalKalikoins = json['totalKalikoins'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
    progress =
        json['userProgress'] == null || (json['userProgress'] as List).isEmpty
            ? 0
            : json['userProgress'][0]['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['challengeTitle'] = this.challengeTitle;
    data['challengeIntro'] = this.challengeIntro;
    data['status'] = this.status;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['totalDuration'] = this.totalDuration;
    data['totalXP'] = this.totalXP;
    data['isActive'] = this.isActive;
    data['totalKalikoins'] = this.totalKalikoins;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    return data;
  }
}

class Category {
  String? sId;
  String? title;
  String? image;
  String? desc;
  bool? isDeleted;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category(
      {this.sId,
      this.title,
      this.image,
      this.desc,
      this.isDeleted,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    desc = json['desc'];
    isDeleted = json['isDeleted'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['isDeleted'] = this.isDeleted;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
