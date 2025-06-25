import 'package:get/get.dart';

class OnBoardingQuestionsModel {
  String? sId;
  String? questionType;
  String? question;
  bool? isActive;
  List<String>? options;
  String? createdAt;
  String? updatedAt;
  int? iV;
  RxList<int> isOptionSelected = <int>[].obs;

  OnBoardingQuestionsModel({
    this.sId,
    this.questionType,
    this.question,
    this.isActive,
    this.options,
    this.createdAt,
    this.updatedAt,
    this.iV,
    required this.isOptionSelected,
  });

  OnBoardingQuestionsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questionType = json['questionType'];
    question = json['question'];
    isActive = json['isActive'];
    options = json['options'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isOptionSelected.value = List.filled(options!.length, 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['questionType'] = this.questionType;
    data['question'] = this.question;
    data['isActive'] = this.isActive;
    data['options'] = this.options;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
