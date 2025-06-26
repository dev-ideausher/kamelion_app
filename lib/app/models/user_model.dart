class UserModel {
  String? sId;
  String? name;
  String? email;
  String? avatardetails;
  String? userType;
  ProfilePic? profilePic;
  String? dob;
  bool? haveLicensekey;
  String? licensekey;
  String? firebaseUid;
  String? firebaseSignInProvider;
  String? rechargePreference;
  String? decisionMakingStyle;
  String? communicationPreference;
  String? motivation;
  String? challengeApproach;
  int? comfortWithNewExperiences;
  String? appNotificationsLastSeenAt;
  String? createdAt;
  String? updatedAt;
  String? nickname;
  num? rewards;
  int? iV;

  UserModel({
    this.sId,
    this.name,
    this.email,
    this.avatardetails,
    this.userType,
    this.profilePic,
    this.dob,
    this.haveLicensekey,
    this.licensekey,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.rechargePreference,
    this.decisionMakingStyle,
    this.communicationPreference,
    this.motivation,
    this.challengeApproach,
    this.comfortWithNewExperiences,
    this.appNotificationsLastSeenAt,
    this.createdAt,
    this.updatedAt,
    this.nickname,
    this.rewards,
    this.iV,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    rewards = json['rewards'];
    email = json['email'];
    avatardetails = json['avatardetails'];
    userType = json['userType'];
    profilePic =
        json['profilePic'] != null
            ? new ProfilePic.fromJson(json['profilePic'])
            : null;
    dob = json['dob'];
    haveLicensekey = json['haveLicensekey'];
    licensekey = json['licensekey'];
    firebaseUid = json['firebaseUid'];
    firebaseSignInProvider = json['firebaseSignInProvider'];
    rechargePreference = json['rechargePreference'];
    decisionMakingStyle = json['decisionMakingStyle'];
    communicationPreference = json['communicationPreference'];
    motivation = json['motivation'];
    challengeApproach = json['challengeApproach'];
    comfortWithNewExperiences = json['comfortWithNewExperiences'];
    appNotificationsLastSeenAt = json['appNotificationsLastSeenAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nickname = json['nickname'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['rewards'] = this.rewards;
    data['email'] = this.email;
    data['avatardetails'] = this.avatardetails;
    data['userType'] = this.userType;
    if (this.profilePic != null) {
      data['profilePic'] = this.profilePic!.toJson();
    }
    data['dob'] = this.dob;
    data['haveLicensekey'] = this.haveLicensekey;
    data['licensekey'] = this.licensekey;
    data['firebaseUid'] = this.firebaseUid;
    data['firebaseSignInProvider'] = this.firebaseSignInProvider;
    data['rechargePreference'] = this.rechargePreference;
    data['decisionMakingStyle'] = this.decisionMakingStyle;
    data['communicationPreference'] = this.communicationPreference;
    data['motivation'] = this.motivation;
    data['challengeApproach'] = this.challengeApproach;
    data['comfortWithNewExperiences'] = this.comfortWithNewExperiences;
    data['appNotificationsLastSeenAt'] = this.appNotificationsLastSeenAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['nickname'] = this.nickname;
    data['__v'] = this.iV;
    return data;
  }
}

class ProfilePic {
  String? key;
  String? url;
  String? sId;

  ProfilePic({this.key, this.url, this.sId});

  ProfilePic.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['url'] = this.url;
    data['_id'] = this.sId;
    return data;
  }
}
