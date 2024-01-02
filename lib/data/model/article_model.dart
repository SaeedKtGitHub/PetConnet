class ArticleModel {
  String? articleId;
  String? writerID;
  String? author;
  String? title;
  String? content;
  String? image;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ArticleModel(
      {this.articleId,
        this.writerID,
        this.author,
        this.title,
        this.content,
        this.image,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    articleId = json['_id'];
    writerID = json['writerID'];
    author = json['author'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = articleId;
    data['writerID'] = writerID;
    data['author'] = author;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
