import 'package:flutter/material.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/data/datasource/remote/auth/sign_up_data.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;
  SignupData signupData = SignupData(Get.find());

  List data = [];

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  StatusRequest? statusRequest = StatusRequest.none;
  @override
  signUp() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await signupData.postData(username.text, email.text, password.text);
      statusRequest = handlingData(response);
      //print("=======================Con" + response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          //TODO: verifyCodeSignUp HERE...After process go to login.
          // data.addAll(response['data']);
          // Get.offNamed(AppRoute.verifyCodeSignUp,
          //     arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
              title: "Warning",
              middleText: "Phone Number Or Email Already Exist ):");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.loginScreen);
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
