import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomTitleWithIcon extends StatelessWidget {
  const CustomTitleWithIcon(
      {super.key,
      required this.numOfText,
      required this.imagePath,
      required this.onPressed});
  final String numOfText;
  final String imagePath;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          child: Image.asset(
            imagePath,
            height: 35.h,
            width: 35.w,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 6,
        ),
        Text(
          numOfText.tr,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.black),
        ),
      ],
    );
  }
}
