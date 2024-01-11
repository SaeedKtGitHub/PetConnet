import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

showDefDialog({
  required String title,
  required String message,
  required void Function()? onNoPressed,
  required void Function()? onYesPressed,
}) {
  Get.defaultDialog(
    titleStyle: const TextStyle(color: AppColor.primaryColor),
    middleTextStyle: const TextStyle(color: AppColor.black, fontSize: 20),
    title: title,
    middleText: message,
    actions: [
      ElevatedButton(
          onPressed: onNoPressed,
          child:  Text(
            '104'.tr,
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
      ElevatedButton(
          onPressed: onYesPressed,
          child:  Text(
            '103'.tr,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
    ],
  );
}
