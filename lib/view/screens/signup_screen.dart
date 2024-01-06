import 'package:pet_connect/controller/auth/login_controller.dart';
import 'package:pet_connect/controller/auth/signup_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/alert_exit_app.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_sign_up_in.dart';
import 'package:pet_connect/view/widgets/auth/logo_auth.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backgroundColorWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundColorWhite,
        elevation: 0.0,
        title: Text(
          '9'.tr,
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    //const LogoAuth(),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(AppImageAsset.logo),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextForm(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 3, 30, 'username');
                      },
                      myController: controller.username,
                      hintText: "10".tr,
                      labelText: "11".tr,
                      iconData: Icons.person_outline,
                      //myController: myController
                    ),
                    CustomTextForm(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, 'email');
                      },
                      myController: controller.email,
                      hintText: "3".tr,
                      labelText: "4".tr,
                      iconData: Icons.email_outlined,
                      //myController: myController
                    ),
                    GetBuilder<SignUpControllerImp>(
                      builder: (controller) => CustomTextForm(
                        obscureText: controller.isShowPassword,
                        isNumber: false,
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        valid: (val) {
                          return validInput(val!, 5, 40, 'password');
                        },
                        myController: controller.password,
                        hintText: "5".tr,
                        labelText: "6".tr,
                        iconData: controller.isShowPassword == true
                            ? Icons.lock_outline
                            : Icons.lock_open_outlined,
                        //myController: myController
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAuth(
                        text: '9'.tr,
                        onPressed: () {
                          controller.signUp();
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextSignUpOrSignIn(
                        textOne: '12'.tr,
                        textTwo: '1'.tr,
                        onTap: () {
                          controller.goToSignIn();
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
