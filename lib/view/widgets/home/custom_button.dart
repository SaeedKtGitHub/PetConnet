import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0.h, 25.h),
        backgroundColor: AppColor.primaryColor, // Assuming AppColor is defined
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 13.0.w, vertical: 2.0.h),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 13.0.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
