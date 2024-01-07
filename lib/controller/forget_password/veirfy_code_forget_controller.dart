import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/data/datasource/remote/forget_password/verify_code_forget_pass_data.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword(String verifyCode);
}

class VerifyCodeControllerImp extends VerifyCodeController {
  String? email;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
      VerifyCodeForgetPasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  @override
  checkCode() {}

  @override
  goToResetPassword(String verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeForgetPasswordData.postData(email!, verifyCode);
    statusRequest = handlingData(response);
    //print("=======================Con" + response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // data.addAll(response['data']);
        Get.offNamed(AppRoute.resetPasswordScreen, arguments: {"email": email});
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
    email = Get.arguments['email'];
    super.onInit();
  }
}
