import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("isLogin") == "true") {
      return const RouteSettings(name: AppRoute.homeScreen);
    }
    return null;
  }
}
