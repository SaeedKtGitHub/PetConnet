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
}
