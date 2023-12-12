import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomAddPetButton extends StatelessWidget {
  const CustomAddPetButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: CircleAvatar(
            backgroundColor: AppColor.primaryColor,
            radius: 45.h, // Adjust the radius as needed
            child: Icon(
              Icons.add_circle_outline,
              color: AppColor.white,
              size: 55.h, // Adjust the icon size as needed
            ),
          ),
        ),
        Text(
          '19'.tr,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor),
        ),
      ],
    );
  }
}
