import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/forget_password/forget_pass_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_body_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_title_auth.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundColorWhite,
        elevation: 0.0,
        title: Text(
          '68'.tr,
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Form(
                  key: controller.formState,
                  child: ListView(children: [
                    const SizedBox(height: 20),
                    CustomTextTitleAuth(text: '69'.tr),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                        // please Enter Your Email Address To Recive A verification code
                        text: '70'.tr),
                    const SizedBox(height: 15),
                    CustomTextForm(
                      isNumber: false,
                      valid: (val) {},
                      myController: controller.email,
                      hintText: "3".tr,
                      iconData: Icons.email_outlined,
                      labelText: "4".tr,
                      // mycontroller: ,
                    ),
                    CustomButtonAuth(
                        text: "30".tr,
                        onPressed: () {
                          controller.checkEmail();
                        }),
                    const SizedBox(height: 40),
                  ]),
                ),
              ))),
    );
  }
}
