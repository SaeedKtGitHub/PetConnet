import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/data/datasource/remote/auth/verify_code_sign_up_data.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verifyCodeSignUp);
  reSend();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerifyCodeSignupData verifyCodeSignupData = VerifyCodeSignupData(Get.find());

  String? email;

  StatusRequest statusRequest = StatusRequest.none;

  @override
  checkCode() {}

  @override
  goToSuccessSignUp(verifyCodeSignUp) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeSignupData.postData(email!, verifyCodeSignUp);
    statusRequest = handlingData(response);
    //print("=======================Con" + response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // data.addAll(response['data']);
        Get.offNamed(AppRoute.successSignUpScreen);
      } else {
        Get.defaultDialog(
            title: "Warning", middleText: "Verify Code Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    //email = Get.arguments['email'];
    super.onInit();
  }

  @override
  reSend() {
    verifyCodeSignupData.resendData(email!);
  }
}
