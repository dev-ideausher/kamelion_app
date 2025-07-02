class BadgeModel {
  BadgeImage? badgeImage;
  String? sId;
  String? name;
  String? description;
  String? activityType;
  String? conditionType;
  int? conditionValue;
  int? totalXp;
  int? totalKalikoins;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  num? progress;
  int? iV;

  BadgeModel(
      {this.badgeImage,
      this.sId,
      this.name,
      this.progress,
      this.description,
      this.activityType,
      this.conditionType,
      this.conditionValue,
      this.totalXp,
      this.totalKalikoins,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BadgeModel.fromJson(Map<String, dynamic> json) {
    badgeImage = json['badgeImage'] != null
        ? new BadgeImage.fromJson(json['badgeImage'])
        : null;
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    activityType = json['activityType'];
    conditionType = json['conditionType'];
    conditionValue = json['conditionValue'];
    totalXp = json['totalXp'];
    totalKalikoins = json['totalKalikoins'];
    expiryDate = json['expiryDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    progress =
        json['userProgress'] == null ? 0 : json['userProgress'][0]['progress'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.badgeImage != null) {
      data['badgeImage'] = this.badgeImage!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['activityType'] = this.activityType;
    data['conditionType'] = this.conditionType;
    data['conditionValue'] = this.conditionValue;
    data['totalXp'] = this.totalXp;
    data['totalKalikoins'] = this.totalKalikoins;
    data['expiryDate'] = this.expiryDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class BadgeImage {
  String? key;
  String? url;

  BadgeImage({this.key, this.url});

  BadgeImage.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['url'] = this.url;
    return data;
  }
}
