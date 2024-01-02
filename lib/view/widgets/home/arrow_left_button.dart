import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class ArrowLeftButton extends StatelessWidget {
  const ArrowLeftButton({Key? key,
  required this.onPressed,
  }) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0.h, 25.h),
        backgroundColor: AppColor.primaryColor, // Assuming AppColor is defined
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 13.0.w, vertical: 2.0.h),
      ),

      child: Icon(
        Icons.arrow_forward,
        size: 25.h,
        color: AppColor.white,
      ),
    );
  }
}
