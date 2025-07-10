class PersonalityTetModel {
  String? sId;
  String? title;
  String? description;
  bool? isActive;
  List<ScoreMappings>? scoreMappings;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? iV;

  PersonalityTetModel(
      {this.sId,
      this.title,
      this.image,
      this.description,
      this.isActive,
      this.scoreMappings,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PersonalityTetModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    isActive = json['isActive'];
    if (json['scoreMappings'] != null) {
      scoreMappings = <ScoreMappings>[];
      json['scoreMappings'].forEach((v) {
        scoreMappings!.add(new ScoreMappings.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    if (this.scoreMappings != null) {
      data['scoreMappings'] =
          this.scoreMappings!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ScoreMappings {
  double? minScore;
  double? maxScore;
  String? personalityType;
  String? sId;

  ScoreMappings({this.minScore, this.maxScore, this.personalityType, this.sId});

  ScoreMappings.fromJson(Map<String, dynamic> json) {
    minScore = json['minScore'];
    maxScore = json['maxScore'];
    personalityType = json['personalityType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minScore'] = this.minScore;
    data['maxScore'] = this.maxScore;
    data['personalityType'] = this.personalityType;
    data['_id'] = this.sId;
    return data;
  }
}
