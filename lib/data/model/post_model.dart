class PostModel {
  String? userID;
  String? postID;
  String? name;
  String? profilePic;
  String? title;
  String? content;
  String? image;
  String? petID;

  PostModel(
      {this.userID,
      this.postID,
      this.name,
      this.profilePic,
      this.title,
      this.content,
      this.image,
      this.petID});

  PostModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    postID = json['_id'];
    name = json['name'];
    profilePic = json['profilePic'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    petID = json['petID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['postID'] = this.postID;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['petID'] = this.petID;
    return data;
  }
}
