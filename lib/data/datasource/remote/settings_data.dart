import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class SettingsData {
  Crud crud;

  SettingsData(this.crud);

  deletePhone(String userId) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postData(AppLink.deletePhone, {
      "userID": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteAccount(String userId) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postData(AppLink.deleteAccount, {
      "userID": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
