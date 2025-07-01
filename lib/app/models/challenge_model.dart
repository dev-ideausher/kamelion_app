class ChallengeModel {
  String? sId;
  String? challengeTitle;
  String? challengeIntro;
  String? status;
  // String? category;
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
  num? userProgress;

  ChallengeModel(
      {this.sId,
      this.challengeTitle,
      this.challengeIntro,
      this.status,
      // this.category,
      this.type,
      this.totalDuration,
      this.totalXP,
      this.isActive,
      this.totalKalikoins,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image,
      this.isSaved});

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    challengeTitle = json['challengeTitle'];
    challengeIntro = json['challengeIntro'];
    status = json['status'];
    // category = json['category'];
    type = json['type'];
    totalDuration = json['totalDuration'];
    totalXP = json['totalXP'];
    isActive = json['isActive'];
    totalKalikoins = json['totalKalikoins'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['challengeTitle'] = this.challengeTitle;
    data['challengeIntro'] = this.challengeIntro;
    data['status'] = this.status;
    // data['category'] = this.category;
    data['type'] = this.type;
    data['totalDuration'] = this.totalDuration;
    data['totalXP'] = this.totalXP;
    data['isActive'] = this.isActive;
    data['totalKalikoins'] = this.totalKalikoins;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    data['isSaved'] = this.isSaved;
    return data;
  }
}
