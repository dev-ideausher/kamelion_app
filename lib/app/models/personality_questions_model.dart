import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PersonalityQuestionModel {
  String? sId;
  String? title;
  String? description;
  bool? isActive;
  List<ScoreRanges>? scoreRanges;
  String? createdAt;
  String? updatedAt;
  num? iV;
  List<Questions>? questions;
  num? totalQuestions;

  PersonalityQuestionModel(
      {this.sId,
      this.title,
      this.description,
      this.isActive,
      this.scoreRanges,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.questions,
      this.totalQuestions});

  PersonalityQuestionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    isActive = json['isActive'];
    if (json['scoreRanges'] != null) {
      scoreRanges = <ScoreRanges>[];
      json['scoreRanges'].forEach((v) {
        scoreRanges!.add(new ScoreRanges.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    totalQuestions = json['totalQuestions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    if (this.scoreRanges != null) {
      data['scoreRanges'] = this.scoreRanges!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['totalQuestions'] = this.totalQuestions;
    return data;
  }
}

class ScoreRanges {
  num? from;
  num? to;
  String? personalityType;
  bool? selectedStatus;

  ScoreRanges({this.from, this.to, this.personalityType, this.selectedStatus});

  ScoreRanges.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    personalityType = json['personalityType'];
    selectedStatus = json['selectedStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['personalityType'] = this.personalityType;
    data['selectedStatus'] = this.selectedStatus;
    return data;
  }
}

class Questions {
  String? sId;
  String? personality;
  String? question;
  String? typeOfQuestion;
  num? numberOfScales;
  String? order;
  List<Scales>? scales;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Questions(
      {this.sId,
      this.personality,
      this.question,
      this.typeOfQuestion,
      this.numberOfScales,
      this.order,
      this.scales,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    personality = json['personality'];
    question = json['question'];
    typeOfQuestion = json['typeOfQuestion'];
    numberOfScales = json['numberOfScales'];
    order = json['order'];
    if (json['scales'] != null) {
      scales = <Scales>[];
      json['scales'].forEach((v) {
        scales!.add(new Scales.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['personality'] = this.personality;
    data['question'] = this.question;
    data['typeOfQuestion'] = this.typeOfQuestion;
    data['numberOfScales'] = this.numberOfScales;
    data['order'] = this.order;
    if (this.scales != null) {
      data['scales'] = this.scales!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Scales {
  num? scale;
  String? value;
  RxBool isSelected = false.obs;

  Scales({
    this.scale,
    this.value,
  });

  Scales.fromJson(Map<String, dynamic> json) {
    scale = json['scale'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scale'] = this.scale;
    data['value'] = this.value;
    return data;
  }
}
