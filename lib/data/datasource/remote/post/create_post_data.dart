import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class CreatePostData {
  Crud crud;

  CreatePostData(this.crud);

  postDataFile(String userId, String content, String petId, File file) async {
    //TODO: Change link
    var response = await crud.postDataWithFile(
        AppLink.addPost,
        {
          "userID": userId,
          "content": content,
          "petID": petId,
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
}
