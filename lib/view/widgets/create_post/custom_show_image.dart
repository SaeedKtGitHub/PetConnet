import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';

class CustomShowImage extends StatelessWidget {
  const CustomShowImage(
      {super.key, required this.imageFile, required this.onPressed});
  final File imageFile;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11.0.h),
              child: Image.file(
                imageFile,
                width: 340.w,
                height: 150.h,
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 14.h, // Adjust the radius as needed
                child: Image.asset(
                  AppImageAsset.dogIcon,
                  width: 20.w,
                  height: 20.h,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
