import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class ProfileData {
  Crud crud;

  ProfileData(this.crud);

  postDataFile(String userId, File file) async {
    //TODO: Change link
    var response = await crud.postDataWithFile(
        AppLink.addProfilePic,
        {
          "userID": userId,
        },
        file);
    return response.fold((l) => l, (r) => r);
  }

  getData(String userId) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postDataList(AppLink.getUserPets, {
      "userID": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  removePet(String userId, String petId) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postData(AppLink.removePet, {
      "userID": userId,
      "petID": petId,
    });
    return response.fold((l) => l, (r) => r);
  }

  // getUserPosts
  getUserPosts(String userId) async {
    //TODO:Edit the method
    var response = await crud.postDataList(AppLink.getUserPosts, {
      "userID": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  //remove post:
  removePost(String userId, String postId) async {
    var response = await crud.postData(AppLink.removePost, {
      "postID": postId,
      "userID": userId,

    });
    return response.fold((l) => l, (r) => r);
  }


}
