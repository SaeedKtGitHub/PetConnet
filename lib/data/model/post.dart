class Post {
  String? author;
  String? username;
  String? profileImg;
  String? title;
  String? content;
  String? image;
  List<String>? pets;

  Post(
      {this.author,
        this.username,
        this.profileImg,
        this.title,
        this.content,
        this.image,
        this.pets});

  Post.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    username = json['username'];
    profileImg = json['profileImg'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    pets = json['pets'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['username'] = this.username;
    data['profileImg'] = this.profileImg;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['pets'] = this.pets;
    return data;
  }
}
