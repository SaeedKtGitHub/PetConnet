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
        title: 'تحذير',
        message:
            'سيتم حذف جميع البيانات المتعلقة بهذا الحساب \n هل انت متأكد من حذف حسابك؟',
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
              showBottomSnackBar(text: 'تم حذف الحساب بنجاح.');
              myServices.sharedPreferences.clear();
              Get.offAllNamed(AppRoute.loginScreen);
            } else {
              showBottomSnackBar(text: 'حدث خطأ ما, يرجى المحاولة لاحقا.');
              statusRequest = StatusRequest.failure;
            }
          }
          update();
        });
  }

  @override
  deletePhone() {
    showDefDialog(
        title: 'تحذير',
        message:
            'عند حذف رقم الهاتف سيتم حذف جميع المنشورات التي تتضمن رقم هاتفك \n هل تريد حذف رقمك؟',
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
              showBottomSnackBar(text: 'تم حذف رقم الهاتف بنجاح.');
              myServices.sharedPreferences.setString("phone", "");
            } else {
              showBottomSnackBar(text: 'حدث خطأ ما, يرجى المحاولة لاحقا.');
              statusRequest = StatusRequest.failure;
            }
          }
          update();
        });
  }

  @override
  logout() {
    showDefDialog(
        title: 'تنبيه',
        message: 'هل تريد تسجيل الخروج؟',
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
