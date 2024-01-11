import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/show_bottom_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/add_phone_data.dart';

abstract class AddPhoneController extends GetxController {
  addPhone();
}

class AddPhoneControllerImp extends AddPhoneController {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController phone;
  AddPhoneData addPhoneData = AddPhoneData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  bool isEditing = false;
  bool submitted = false;
  @override
  addPhone() async {
    submitted = true;
    if (formState.currentState!.validate()) {
      String ph = myServices.sharedPreferences.getString("phone") ?? '';
      isEditing = !isEditing;
      //TEST
      //myServices.sharedPreferences.setString('editState', isEditing.toString());
      //TEST
      if (ph != phone.text) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await addPhoneData.addPhone(
          myServices.sharedPreferences.getString("userID")!,
          phone.text,
        );
        print(
            "===========response ADDPHONE==================== Controller $response ");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            myServices.sharedPreferences.setString("phone", phone.text);
            showBottomSnackBar(
                text: '161'.tr);
          } else {
            showBottomSnackBar(text: '156'.tr);
            statusRequest = StatusRequest.failure;
          }
        }
      } else {
        //isEditing = !isEditing;
        if (isEditing == true) {
          showBottomSnackBar(text: '162'.tr);
        }
      }

      update();
    } else {}
  }

  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
