
import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class CommentsData {

  Crud crud;

  CommentsData(this.crud);

  //add comment
  postCommentData(String userId,String postID,String content) async {
    //TODO: Change link
    var response = await crud.postData(
        AppLink.addComment,
        {
          "userID": userId,
          "postID": postID,
          "content": content,

        }
        );
    return response.fold((l) => l, (r) => r);
  }

  //get comments:
  getComments(String userId,String postId) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getComments, {
      "userID": userId,
      "postID": postId,
    });
    return response.fold((l) => l, (r) => r);
  }
  //delete comment
  deleteComments(String userId,String postID,String commentId) async {
    //TODO: Change link
    var response = await crud.postData(
        AppLink.deleteComment,
        {
          "userID": userId,
          "postID": postID,
          "commentID": commentId,

        }
    );
    return response.fold((l) => l, (r) => r);
  }





}
