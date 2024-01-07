import 'package:pet_connect/core/class/crud.dart';
import 'package:pet_connect/link_api.dart';

class VerifyCodeSignupData {
  Crud crud;

  VerifyCodeSignupData(this.crud);

  postData(String email, String verifyCode) async {
    var response = await crud.postData(AppLink.verifyCodeSignUp, {
      "email": email,
      "verifyCode": verifyCode,
    });
    return response.fold((l) => l, (r) => r);
  }

  resendData(String email) async {
    var response = await crud.postData(AppLink.resend, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
