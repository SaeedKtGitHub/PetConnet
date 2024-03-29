import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  getAllPosts(String userId) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getAllPosts, {
      "userID": userId,
      // "tag": tag,
    });
    return response.fold((l) => l, (r) => r);
  }
  getPostsByTag(String userId,{required String tag}) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getPostsByTag, {
      "userID": userId,
      "tag":tag
    });
    return response.fold((l) => l, (r) => r);
  }

  // getUser(String userId) async {
  //   //TODO:Edit the method
  //   var response = await crud.postDataList(AppLink.getUser, {
  //     "userID": userId,
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }
  Future<dynamic> getUser(String userId) async {
    var response = await crud.postData(AppLink.getUser, {
      "userID": userId,
    });

    return response.fold((error) => error, (data) => data);
  }

  //remove post:
  removePost(String userId, String postId) async {
    var response = await crud.postData(AppLink.removePost, {
      "postID": postId,
      "userID": userId,

    });
    return response.fold((l) => l, (r) => r);
  }

  //like post:
  likeOrDislike(String userId, String postId) async {
    var response = await crud.postData(AppLink.likeOrDislike, {
      "postID": postId,
      "userID": userId,

    });
    return response.fold((l) => l, (r) => r);
  }
  getRecentPosts() async {
    //TODO:Edit the method
    var response = await crud.postData(AppLink.getRecentPosts, {});
    return response.fold((l) => l, (r) => r);
  }
  //get the posts that the user search on from the homescreen
  getSearchedPosts(String userId,{required String query,required int limit}) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getSearchedPosts, {
      "userID": userId,
      "query":query,
      "limit":limit.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

}
