class CommuntyMembersModel {
  String? userId;
  String? name;
  String? nickname;
  String? avatardetails;
  int? totalXp;

  CommuntyMembersModel(
      {this.userId,
      this.name,
      this.nickname,
      this.avatardetails,
      this.totalXp});

  CommuntyMembersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nickname = json['nickname'];
    avatardetails = json['avatardetails'];
    totalXp = json['totalXp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['avatardetails'] = this.avatardetails;
    data['totalXp'] = this.totalXp;
    return data;
  }
}
