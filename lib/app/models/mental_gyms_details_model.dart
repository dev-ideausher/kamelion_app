class MentalGymDetailsModel {
  MentalGym? mentalGym;
  List<Workouts>? workouts;

  MentalGymDetailsModel({this.mentalGym, this.workouts});

  MentalGymDetailsModel.fromJson(Map<String, dynamic> json) {
    mentalGym = json['mentalGym'] != null
        ? new MentalGym.fromJson(json['mentalGym'])
        : null;
    if (json['workouts'] != null) {
      workouts = <Workouts>[];
      json['workouts'].forEach((v) {
        workouts!.add(new Workouts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mentalGym != null) {
      data['mentalGym'] = this.mentalGym!.toJson();
    }
    if (this.workouts != null) {
      data['workouts'] = this.workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MentalGym {
  Thumbnail? thumbnail;
  String? sId;
  String? title;
  String? description;
  List<Category>? category;
  var totalDuration;
  bool? isActive;
  bool? isJoined;
  bool? isTrending;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isCompleted;
  bool? isSaved;
  num? userProgress;

  MentalGym(
      {this.thumbnail,
      this.sId,
      this.title,
      this.isJoined,
      this.description,
      this.category,
      this.totalDuration,
      this.isActive,
      this.isTrending,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isCompleted,
      this.isSaved,
      this.userProgress});

  MentalGym.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    sId = json['_id'];
    isJoined = json['isJoined'];
    userProgress =
        (json['userProgress'] == null || (json['userProgress'] as List).isEmpty)
            ? 0
            : json['userProgress'][0]['progress'];
    title = json['title'];
    description = json['description'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    totalDuration = json['totalDuration'];
    isActive = json['isActive'];
    isTrending = json['isTrending'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isCompleted = json['isCompleted'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['totalDuration'] = this.totalDuration;
    data['isActive'] = this.isActive;
    data['isTrending'] = this.isTrending;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isCompleted'] = this.isCompleted;
    data['isSaved'] = this.isSaved;
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

class Workouts {
  Thumbnail? video;
  num? progress;
  Thumbnail? thumbnail;
  String? sId;
  String? mentalGym;
  String? workoutTitle;
  var totalDuration;
  int? totalXP;
  int? totalKalikoins;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Workouts({
    this.video,
    this.thumbnail,
    this.sId,
    this.mentalGym,
    this.workoutTitle,
    this.totalDuration,
    this.totalXP,
    this.totalKalikoins,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.progress,
    this.iV,
  });

  Workouts.fromJson(Map<String, dynamic> json) {
    video =
        json['video'] != null ? new Thumbnail.fromJson(json['video']) : null;
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    sId = json['_id'];
    progress = json['progress'];
    mentalGym = json['mentalGym'];
    workoutTitle = json['workoutTitle'];
    totalDuration = json['totalDuration'];
    totalXP = json['totalXP'];
    totalKalikoins = json['totalKalikoins'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    data['_id'] = this.sId;
    data['mentalGym'] = this.mentalGym;
    data['workoutTitle'] = this.workoutTitle;
    data['totalDuration'] = this.totalDuration;
    data['totalXP'] = this.totalXP;
    data['totalKalikoins'] = this.totalKalikoins;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
