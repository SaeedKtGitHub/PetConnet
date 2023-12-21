import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

showSnackBar({
  required String numOfText1,
  required String numOfText2,
}) {
  Get.snackbar(
    '...',
    '...',
    titleText: Text(
      numOfText1.tr,
      style: const TextStyle(
        color: AppColor.white,
        fontSize: 27,
      ),
    ),
    messageText: Text(
      numOfText2.tr,
      style: const TextStyle(color: AppColor.black, fontSize: 20),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: AppColor.primaryColor,
    borderColor: AppColor.black,
    borderWidth: 2,
  );
}
