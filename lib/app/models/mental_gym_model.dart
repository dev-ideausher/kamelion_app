class MentalGymModel {
  Thumbnail? thumbnail;
  String? sId;
  String? title;
  String? description;
  int? totalDuration;
  String? createdAt;
  String? updatedAt;
  int? iV;
  // Category? category;
  bool? isSaved;
  num? userProgress;
  List<Category>? category;

  MentalGymModel(
      {this.thumbnail,
      this.sId,
      this.title,
      this.description,
      this.totalDuration,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.category,
      this.isSaved,
      this.userProgress});

  MentalGymModel copyWith(
      {Thumbnail? thumbnail,
      String? sId,
      String? title,
      String? description,
      int? totalDuration,
      String? createdAt,
      String? updatedAt,
      int? iV,
      List<Category>? category,
      bool? isSaved,
      num? userProgress}) {
    return MentalGymModel(
        thumbnail: thumbnail ?? this.thumbnail,
        sId: sId ?? this.sId,
        title: title ?? this.title,
        description: description ?? this.description,
        totalDuration: totalDuration ?? this.totalDuration,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        iV: iV ?? this.iV,
        category: category ?? this.category,
        isSaved: isSaved ?? this.isSaved,
        userProgress: userProgress ?? this.userProgress);
  }

  MentalGymModel.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    totalDuration = json['totalDuration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isSaved = json['isSaved'];
    userProgress =
        (json['userProgress'] == null || (json['userProgress'] as List).isEmpty)
            ? 0
            : json['userProgress'][0]['progress'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    // category =
    //     json['category'] != null
    //         ? new Category.fromJson(json['category'])
    //         : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['totalDuration'] = this.totalDuration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isSaved'] = this.isSaved;
    data['__v'] = this.iV;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thumbnail {
  String? key;
  String? url;

  Thumbnail({this.key, this.url});

  Thumbnail.fromJson(Map<String, dynamic> json) {
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

  Category({
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
