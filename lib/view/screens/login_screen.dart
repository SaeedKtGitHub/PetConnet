import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/controller/auth/login_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/functions/alert_exit_app.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_sign_up_in.dart';
import 'package:pet_connect/view/widgets/auth/logo_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backgroundColorWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundColorWhite,
        elevation: 0.0,
        title: Text(
          '1'.tr,
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Form(
                  key: controller.formState,
                  child: ListView(
                    children: [
                      const LogoAuth(),
                      const SizedBox(height: 40),
                      CustomTextForm(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 4, 100, 'email');
                        },
                        myController: controller.email,
                        hintText: "3".tr,
                        labelText: "4".tr,
                        iconData: Icons.email_outlined,
                        //myController: myController
                      ),
                      GetBuilder<LoginControllerImp>(
                        builder: (controller) => CustomTextForm(
                          obscureText: controller.isShowPassword,
                          isNumber: false,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          valid: (val) {
                            return validInput(val!, 4, 40, 'password');
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
                      InkWell(
                        onTap: () {
                          //controller.goToForgetPassword();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: AppColor.primaryColor,
                            ),
                            Text(
                              '7'.tr,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: AppColor.primaryColor, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButtonAuth(
                          text: '1'.tr,
                          onPressed: () {
                            controller.login();
                          }),
                      const SizedBox(
                        height: 60,
                      ),
                      CustomTextSignUpOrSignIn(
                          textOne: '8'.tr,
                          textTwo: '9'.tr,
                          onTap: () {
                            controller.goToSignUp();
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '57'.tr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            //TODO: Web view
                            onTap: () {},
                            child: Text(
                              textAlign: TextAlign.center,
                              '48'.tr,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primaryColor,
                                  color: AppColor.primaryColor),
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            //and
                            '55'.tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          InkWell(
                            //TODO: Web view
                            onTap: () {},
                            child: Text(
                              textAlign: TextAlign.center,
                              '56'.tr,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primaryColor,
                                  color: AppColor.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
