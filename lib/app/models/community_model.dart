class CommunityModel {
  ProfileImage? profileImage;
  int? numberOfMembers;
  List<String>? members;
  String? status;
  String? reason;
  String? sId;
  UserId? userId;
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
  bool? isJoin;
  bool? hasOpened;
  int? numberofPosts;
  String? nickname;
  bool? isMember;

  CommunityModel({
    this.profileImage,
    this.numberOfMembers,
    this.members,
    this.status,
    this.reason,
    this.sId,
    this.userId,
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
    this.isJoin,
    this.hasOpened,
    this.nickname,
    this.isMember,
  });

  CommunityModel.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'] != null
        ? new ProfileImage.fromJson(json['profileImage'])
        : null;
    numberOfMembers = json['numberOfMembers'];
    members = json['members'].cast<String>();
    status = json['status'];
    reason = json['reason'];
    sId = json['_id'];
    hasOpened = json['hasOpened'];
    isMember = json['isMember'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    name = json['name'];
    category = json['category'] != null
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
    isJoin = json['isJoin'];
    numberofPosts = json['numberofPosts'];
    nickname = json['userId'] != null ? json['userId']['nickname'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.toJson();
    }
    data['numberOfMembers'] = this.numberOfMembers;
    data['members'] = this.members;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['isMember'] = this.isMember;
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
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
    data['isJoin'] = this.isJoin;
    data['numberofPosts'] = this.numberofPosts;
    data['hasOpened'] = this.hasOpened;
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
    this.avatarType,
    this.appNotificationsLastSeenAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLoginDate,
    this.rewards,
    this.isActive,
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
    avatarType = json['avatarType'];
    appNotificationsLastSeenAt = json['appNotificationsLastSeenAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastLoginDate = json['lastLoginDate'];
    rewards = json['rewards'];
    isActive = json['isActive'];
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
