
class User {
  String? name;
  String? photo;
  String? email;
  String? role;

  User({this.name, this.photo, this.email, this.role});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
