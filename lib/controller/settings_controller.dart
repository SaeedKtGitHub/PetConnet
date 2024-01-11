import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/show_bottom_snack_bar.dart';
import 'package:pet_connect/core/functions/show_dialog.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/settings_data.dart';

abstract class SettingsController extends GetxController {
  goToProfilePage();
  goToAddPhoneNumberScreen();
  logout();
  deleteAccount();
  deletePhone();
}

class SettingsControllerImp extends SettingsController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  SettingsData settingsData = SettingsData(Get.find());

  @override
  deleteAccount() {
    showDefDialog(
        title: '101'.tr,
        message:
            '163'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () async {
          // TODO: delete account
          statusRequest = StatusRequest.loading;
          update();
          var response = await settingsData
              .deleteAccount(myServices.sharedPreferences.getString("userID")!);
          statusRequest = handlingData(response);
          //print('SSSSSSSSSSSSSSSSSSSSSSS--->  $response');
          if (StatusRequest.success == statusRequest) {
            if (response['status'] == "success") {
              showBottomSnackBar(text: '164'.tr);
              myServices.sharedPreferences.clear();
              Get.offAllNamed(AppRoute.loginScreen);
            } else {
              showBottomSnackBar(text: '156'.tr);
              statusRequest = StatusRequest.failure;
            }
          }
          update();
        });
  }

  @override
  deletePhone() {
    showDefDialog(
        title: '101'.tr,
        message:
            '165'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () async {
          // TODO: delete phone
          Get.back();
          statusRequest = StatusRequest.loading;
          update();
          var response = await settingsData
              .deletePhone(myServices.sharedPreferences.getString("userID")!);
          statusRequest = handlingData(response);
          //print('SSSSSSSSSSSSSSSSSSSSSSS--->  $response');
          if (StatusRequest.success == statusRequest) {
            if (response['status'] == "success") {
              showBottomSnackBar(text: '166'.tr);
              myServices.sharedPreferences.setString("phone", "");
            } else {
              showBottomSnackBar(text: '156'.tr);
              statusRequest = StatusRequest.failure;
            }
          }
          update();
        });
  }

  @override
  logout() {
    showDefDialog(
        title: '101'.tr,
        message: '167'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () {
          myServices.sharedPreferences.clear();
          Get.offAllNamed(AppRoute.loginScreen);
        });
  }

  @override
  goToProfilePage() {
    // TODO: implement goToProfilePage
    //TEST
    Get.toNamed(AppRoute.profileScreen, arguments: {"screenName": "home"});
    //TEST
  }

  @override
  goToAddPhoneNumberScreen() {
    // TODO: implement addPhoneNumber
    Get.toNamed(AppRoute.addPhoneScreen);
  }
}
