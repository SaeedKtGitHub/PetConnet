import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class CreatePostData {
  Crud crud;

  CreatePostData(this.crud);

  postDataFile(String userId, String address, File file) async {
    //TODO: Change link
    var response = await crud.postDataWithFile(
        AppLink.login,
        {
          "userId": userId,
          "address": address,
        },
        file);
    return response.fold((l) => l, (r) => r);
  }

  getData(String usersId, String petId) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postData(AppLink.login, {
      "usersId": usersId,
      "petId": petId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
