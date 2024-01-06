import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showBottomSnackBar({
  required String text,
}) {
  Get.snackbar(
    "...",
    '...',
    duration: const Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
    titleText: Text(
      text,
      style: TextStyle(fontSize: 18.0.sp), // Adjust the font size as needed
    ),
  );
}
