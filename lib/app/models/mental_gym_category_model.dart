class MentalGymCategoryModel {
  String? sId;
  String? title;
  String? image;
  String? desc;
  bool? isDeleted;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MentalGymCategoryModel({
    this.sId,
    this.title,
    this.image,
    this.desc,
    this.isDeleted,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  @override
  String toString() => title ?? "";

  MentalGymCategoryModel.fromJson(Map<String, dynamic> json) {
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
