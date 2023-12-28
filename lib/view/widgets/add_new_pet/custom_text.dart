import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key,
    required this.numOfText,
  }) : super(key: key);
  final String numOfText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0.w),
      child: Row(
        children: [
          Text(
            numOfText.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,

            ),
          ),
        ],
      ),
    );
  }
}
