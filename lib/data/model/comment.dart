class CommentModel {
  String? commentId;
  String? userID;
  String? name;//username
  String? content;
  String? profilePic;
  String? date;


  CommentModel(
      {
        this.commentId,
        this.userID,
        this.name,
        this.content,
        this.profilePic,
        this.date,
      });

  // CommentModel.fromJson(Map<String, dynamic> json) {
  //   userID = json['userID'];
  //   name = json[' name'];
  //   content = json['content'];
  //   profilePic = json['profilePic'];
  //   date = json['date'];
  // }
  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['_id'];
    userID = json['userID'];
    name = json['name'];  // Remove the space before 'name'
    content = json['content'];
    profilePic = json['profilePic'];
    date = json['date'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['name'] = name;
    data['content'] = content;
    data['profilePic'] = profilePic;
    data['date'] = date;
    data['_id']=commentId;
    return data;
  }
}
