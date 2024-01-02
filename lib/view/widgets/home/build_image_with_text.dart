import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class BuildImageWithText extends StatelessWidget {
  final String imagePath;
  final String text;

  const BuildImageWithText({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0.h),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 170.h,
            fit: BoxFit.cover,
          ),
        ),



        Padding(
          padding: EdgeInsets.only(bottom: 8.0.h,right: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start, // Align the first text to the center
            children: [
              // Article title
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              // Article writer aligned to the right
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Dr,Ali Alktefani',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

            ],
          ),
        ),
      ],
    );
  }
}
