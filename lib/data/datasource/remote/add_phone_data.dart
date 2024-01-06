import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class AddPhoneData {
  Crud crud;

  AddPhoneData(this.crud);

  addPhone(String userId, String phone) async {
    //TODO: ASK Ahmad about param. and Change link.
    var response = await crud.postData(AppLink.addPhone, {
      "userID": userId,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
