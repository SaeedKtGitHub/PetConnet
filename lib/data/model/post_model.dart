

import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/data/model/pet_model.dart';

class PostModel {
  String? userID;
  String? postID;
  String? username;
  String? profilePic;
  String? title;
  String? content;
  String? image;
  String? petID;
  String? petName;
  String? date;
  String? tag;
  PetModel? petModel;
  double ? price;
  List<String>? likes;//list of userids
  List<CommentModel>? comments;
  String? userPhone;

  PostModel(
      {this.userID,
      this.postID,
      this.username,
      this.profilePic,
      this.title,
      this.content,
      this.image,
      this.petID,
        this.petName,
        this.date,
       this.tag,
        this.petModel,
        this.price,
        this.likes,
        this.comments,
        this.userPhone,
      });

  //After editing (according to json response) :
  PostModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID']["_id"];
    postID = json['_id'];
    username = json['userID']['name'];
    profilePic = json['userID']['profilePic'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    petID = json['petID']['_id'];
    petName = json['petID']['name'];
    date=json['date'];
    tag=json['tag'];
    petModel=PetModel.fromJson(json['petID']);
    price = json['price']?.toDouble();
     likes = List<String>.from(json['likes'] ?? []);
        //comments:
        if (json['comments'] != null) {
          comments = (json['comments'] as List<dynamic>)
              .map((commentJson) => CommentModel.fromJson(commentJson))
              .toList()
              .cast<CommentModel>();
        } else {
          comments = [];
        }
      userPhone = json['userID']['phone'];

  }
  // PostModel.fromJson(Map<String, dynamic> json) {
  //   userID = json['userID'];
  //   postID = json['_id'];
  //   name = json['name'];
  //   profilePic = json['profilePic'];
  //   title = json['title'];
  //   content = json['content'];
  //   image = json['image'];
  //   petID = json['petID'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['postID'] = postID;
    data['name'] = petName;
    data['profilePic'] = profilePic;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['petID'] = petID;
    data['date'] = date;
    data['tag']=tag;
    data['petID']=petModel;
    data['price']=price;
    data['userID']['phone']=userPhone;
    return data;
  }
}
