import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  postData(String username, String email, String password) async {
    var response = await crud.postData(AppLink.signUp, {
      "name": username,
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
