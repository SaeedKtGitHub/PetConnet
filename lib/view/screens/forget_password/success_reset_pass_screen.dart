import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/forget_password/success_reset_pass_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';

class SuccessResetPasswordScreen extends StatelessWidget {
  const SuccessResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordControllerImp controller =
        Get.put(SuccessResetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundColorWhite,
        elevation: 0.0,
        title: Text(
          '75'.tr,
          style: const TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(
              child: Icon(
            Icons.check_circle_outline,
            size: 200,
            color: AppColor.primaryColor,
          )),
          Text("76".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 35)),
          Text("77".tr,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 24)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: CustomButtonAuth(
                text: "78".tr,
                onPressed: () {
                  controller.goToPageLogin();
                }),
          ),
        ]),
      ),
    );
  }
}
