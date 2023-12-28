import 'dart:io';

import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class AddNewPetData {

  Crud crud;

  AddNewPetData(this.crud);

  //add pet
  postPetData(String userId, String name, String type,
      String breed,String gender,String birthDate, File file) async {
    //TODO: Change link
    var response = await crud.postDataWithFile(
        AppLink.addPet,
        {
          "userID": userId,
          "name": name,
          "type": type,
          "breed": breed,
          "gender": gender,
          "birthDate": birthDate,
        },
        file);
    return response.fold((l) => l, (r) => r);
  }


}
