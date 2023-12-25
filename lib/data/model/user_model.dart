class UserModel {
  String? userID;
  String? name;
  String? profilePic;
  String? email;
  String? role;

  UserModel({this.userID, this.name, this.profilePic, this.email, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['_id'];
    name = json['name'];
    profilePic = json['profilePic'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['name'] = name;
    data['profilePic'] = profilePic;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
