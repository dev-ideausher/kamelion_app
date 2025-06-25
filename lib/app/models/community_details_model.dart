class CommunityDetailsModel {
  Community? community;
  List<Posts>? posts;

  CommunityDetailsModel({this.community, this.posts});

  CommunityDetailsModel.fromJson(Map<String, dynamic> json) {
    community =
        json['community'] != null
            ? new Community.fromJson(json['community'])
            : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Community {
  ProfileImage? profileImage;
  String? status;
  String? reason;
  String? sId;
  UserIdCommunity? userIdCommunity;
  String? name;
  Category? category;
  bool? isActive;
  bool? isReported;
  bool? isVerified;
  bool? hasLeft;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isTrending;
  int? numberofPosts;
  List<String>? members;
  int? numberOfMembers;

  Community({
    this.profileImage,
    this.status,
    this.reason,
    this.sId,
    this.userIdCommunity,
    this.name,
    this.category,
    this.isActive,
    this.isReported,
    this.isVerified,
    this.hasLeft,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.isTrending,
    this.numberofPosts,
    this.members,
    this.numberOfMembers,
  });

  Community.fromJson(Map<String, dynamic> json) {
    profileImage =
        json['profileImage'] != null
            ? new ProfileImage.fromJson(json['profileImage'])
            : null;
    status = json['status'];
    reason = json['reason'];
    sId = json['_id'];
    userIdCommunity =
        json['userIdCommunity'] != null
            ? new UserIdCommunity.fromJson(json['userIdCommunity'])
            : null;
    name = json['name'];
    category =
        json['category'] != null
            ? new Category.fromJson(json['category'])
            : null;
    isActive = json['isActive'];
    isReported = json['isReported'];
    isVerified = json['isVerified'];
    hasLeft = json['hasLeft'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isTrending = json['isTrending'];
    numberofPosts = json['numberofPosts'];
    members = json['members'].cast<String>();
    numberOfMembers = json['numberOfMembers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.toJson();
    }
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['_id'] = this.sId;
    if (this.userIdCommunity != null) {
      data['userIdCommunity'] = this.userIdCommunity!.toJson();
    }
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['isActive'] = this.isActive;
    data['isReported'] = this.isReported;
    data['isVerified'] = this.isVerified;
    data['hasLeft'] = this.hasLeft;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isTrending'] = this.isTrending;
    data['numberofPosts'] = this.numberofPosts;
    data['members'] = this.members;
    data['numberOfMembers'] = this.numberOfMembers;
    return data;
  }
}

class ProfileImage {
  String? url;

  ProfileImage({this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class UserIdCommunity {
  String? sId;
  String? name;
  String? email;
  String? userType;
  String? dob;
  bool? haveLicensekey;
  Null? licensekey;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? nickname;
  Null? avatarImage;
  String? avatardetails;
  String? avatarType;
  String? appNotificationsLastSeenAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLoginDate;
  int? rewards;
  bool? isActive;
  List<String>? favouritePosts;

  UserIdCommunity({
    this.sId,
    this.name,
    this.email,
    this.userType,
    this.dob,
    this.haveLicensekey,
    this.licensekey,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.nickname,
    this.avatarImage,
    this.avatardetails,
    this.avatarType,
    this.appNotificationsLastSeenAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLoginDate,
    this.rewards,
    this.isActive,
    this.favouritePosts,
  });

  UserIdCommunity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    dob = json['dob'];
    haveLicensekey = json['haveLicensekey'];
    licensekey = json['licensekey'];
    firebaseUid = json['firebaseUid'];
    firebaseSignInProvider = json['firebaseSignInProvider'];
    nickname = json['nickname'];
    avatarImage = json['avatarImage'];
    avatardetails = json['avatardetails'];
    avatarType = json['avatarType'];
    appNotificationsLastSeenAt = json['appNotificationsLastSeenAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastLoginDate = json['lastLoginDate'];
    rewards = json['rewards'];
    isActive = json['isActive'];
    favouritePosts = json['favouritePosts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userType'] = this.userType;
    data['dob'] = this.dob;
    data['haveLicensekey'] = this.haveLicensekey;
    data['licensekey'] = this.licensekey;
    data['firebaseUid'] = this.firebaseUid;
    data['firebaseSignInProvider'] = this.firebaseSignInProvider;
    data['nickname'] = this.nickname;
    data['avatarImage'] = this.avatarImage;
    data['avatardetails'] = this.avatardetails;
    data['avatarType'] = this.avatarType;
    data['appNotificationsLastSeenAt'] = this.appNotificationsLastSeenAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lastLoginDate'] = this.lastLoginDate;
    data['rewards'] = this.rewards;
    data['isActive'] = this.isActive;
    data['favouritePosts'] = this.favouritePosts;
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

class Posts {
  bool? isReport;
  String? sId;
  String? description;
  UserId? userId;
  String? community;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? likeCount;
  int? commentCount;
  bool? isLiked;
  bool? addFavorite;

  Posts({
    this.isReport,
    this.sId,
    this.description,
    this.userId,
    this.community,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.addFavorite,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    isReport = json['isReport'];
    sId = json['_id'];
    description = json['description'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    // community = json['community'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    isLiked = json['isLiked'];
    addFavorite = json['addFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isReport'] = this.isReport;
    data['_id'] = this.sId;
    data['description'] = this.description;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['community'] = this.community;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    data['isLiked'] = this.isLiked;
    data['addFavorite'] = this.addFavorite;
    return data;
  }
}

class UserId {
  String? sId;
  String? name;
  String? email;
  String? userType;
  String? dob;
  bool? haveLicensekey;
  String? licensekey;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? nickname;
  String? avatarImage;
  String? avatardetails;
  int? rewards;
  String? avatarType;
  bool? isActive;
  String? appNotificationsLastSeenAt;
  List<Answers>? answers;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLoginDate;

  UserId({
    this.sId,
    this.name,
    this.email,
    this.userType,
    this.dob,
    this.haveLicensekey,
    this.licensekey,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.nickname,
    this.avatarImage,
    this.avatardetails,
    this.rewards,
    this.avatarType,
    this.isActive,
    this.appNotificationsLastSeenAt,
    this.answers,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLoginDate,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    dob = json['dob'];
    haveLicensekey = json['haveLicensekey'];
    licensekey = json['licensekey'];
    firebaseUid = json['firebaseUid'];
    firebaseSignInProvider = json['firebaseSignInProvider'];
    nickname = json['nickname'];
    avatarImage = json['avatarImage'];
    avatardetails = json['avatardetails'];
    rewards = json['rewards'];
    avatarType = json['avatarType'];
    isActive = json['isActive'];
    appNotificationsLastSeenAt = json['appNotificationsLastSeenAt'];
    // if (json['answers'] != null) {
    //   answers = <Answers>[];
    //   json['answers'].forEach((v) {
    //     answers!.add(new Answers.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastLoginDate = json['lastLoginDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userType'] = this.userType;
    data['dob'] = this.dob;
    data['haveLicensekey'] = this.haveLicensekey;
    data['licensekey'] = this.licensekey;
    data['firebaseUid'] = this.firebaseUid;
    data['firebaseSignInProvider'] = this.firebaseSignInProvider;
    data['nickname'] = this.nickname;
    data['avatarImage'] = this.avatarImage;
    data['avatardetails'] = this.avatardetails;
    data['rewards'] = this.rewards;
    data['avatarType'] = this.avatarType;
    data['isActive'] = this.isActive;
    data['appNotificationsLastSeenAt'] = this.appNotificationsLastSeenAt;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['lastLoginDate'] = this.lastLoginDate;
    return data;
  }
}

class Answers {
  String? questionId;
  List<String>? selectedOptions;
  String? sId;

  Answers({this.questionId, this.selectedOptions, this.sId});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    selectedOptions = json['selectedOptions'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['selectedOptions'] = this.selectedOptions;
    data['_id'] = this.sId;
    return data;
  }
}
