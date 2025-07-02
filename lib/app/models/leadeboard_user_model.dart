class LeaderBoardUserModel {
  User? user;
  int? totalXP;

  LeaderBoardUserModel({this.user, this.totalXP});

  LeaderBoardUserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    totalXP = json['totalXP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['totalXP'] = this.totalXP;
    return data;
  }
}

class User {
  String? sId;
  String? avatardetails;
  String? nickname;

  User({this.sId, this.avatardetails, this.nickname});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    avatardetails = json['avatardetails'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['avatardetails'] = this.avatardetails;
    data['nickname'] = this.nickname;
    return data;
  }
}
