class CommentModel {
  UserId? userId;
  String? text;
  String? sId;
  String? createdAt;
  List<CommentModel> replies;
  CommentModel({this.userId, this.text, this.sId, this.createdAt,  List<CommentModel>? replies,}): replies = replies ?? [];

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'] != null
          ? UserId.fromJson(json['userId'] as Map<String, dynamic>)
          : null,
      text: json['text'] as String?,
      sId: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      replies: (json['replies'] as List<dynamic>?)
          ?.map((r) => CommentModel.fromJson(r as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId!.toJson(),
      'text': text,
      '_id': sId,
      'createdAt': createdAt,
      'replies': replies.map((r) => r.toJson()).toList(),
    };
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
  String? avatarType;
  String? appNotificationsLastSeenAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLoginDate;
  int? rewards;
  bool? isActive;
  List<String>? favouritePosts;

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
    this.favouritePosts,
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
