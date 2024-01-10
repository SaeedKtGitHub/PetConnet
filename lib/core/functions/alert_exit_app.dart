import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    titleStyle: const TextStyle(color: AppColor.primaryColor),
    middleTextStyle: const TextStyle(color: AppColor.black, fontSize: 20),
    title: '101'.tr,
    middleText: '102'.tr,
    actions: [
      ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child:  Text(
            '104'.tr,
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
      ElevatedButton(
          onPressed: () {
            exit(0);
          },
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
  return Future.value(true);
}
