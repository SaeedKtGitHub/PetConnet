import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class CreatePostData {
  Crud crud;

  CreatePostData(this.crud);

  Future postDataFile(
      String userId, String content, String petId, String tag, File file,
      {String? price}) async {
    // TODO: Change link
    var response = await crud.postDataWithFile(
      AppLink.addPost,
      {
        "userID": userId,
        "content": content,
        "petID": petId,
        "tag": tag,
        if (price != null) "price": price, // Include price if provided
      },
      file,
    );
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
