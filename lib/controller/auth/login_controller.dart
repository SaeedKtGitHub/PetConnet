import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/auth/login_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  // goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(
        email.text,
        password.text,
      );
      print(
          "===========response LOGIN==================== Controller $response ");
      statusRequest = handlingData(response);
      print('SSSSSSSSSSSSSSSSSSSSSSS--->  $response');
      //print("=======================Con" + response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          myServices.sharedPreferences.setString("isLogin", "true");
          // TODO: Use data from ahmad
          myServices.sharedPreferences
              .setString("userID", response['data']['userID']);
          myServices.sharedPreferences
              .setString("username", response['data']['name']);
          myServices.sharedPreferences
              .setString("email", response['data']['email']);
          myServices.sharedPreferences
              .setString("profilePic", response['data']['profilePic']);
          myServices.sharedPreferences
              .setString("phone", response['data']['phone']);
          print('LOGIN ---> ${response['data']['profilePic']}');
          Get.offNamed(AppRoute.homeScreen);
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signupScreen);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  //
  // @override
  // goToForgetPassword() {
  //   Get.toNamed(AppRoute.forgetPassword);
  // }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
