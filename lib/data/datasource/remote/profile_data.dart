import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class ProfileData {
  Crud crud;

  ProfileData(this.crud);

  postDataFile(String userId, File file) async {
    //TODO: Change link
    var response = await crud.postDataWithFile(
        AppLink.addPost,
        {
          "userID": userId,
        },
        file);
    return response.fold((l) => l, (r) => r);
  }
}
