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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
