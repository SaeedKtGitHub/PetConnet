import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomChooseImageButton extends StatelessWidget {
  const CustomChooseImageButton(
      {super.key,
      required this.numOfText,
      required this.iconData,
      required this.onPressed});
  final String numOfText;
  final void Function()? onPressed;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159.w,
      height: 100.h,
      margin: EdgeInsets.only(top: 9.h),
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textColor: Colors.white,
        color: AppColor.primaryColor,
        child: Column(
          children: [
            Icon(
              iconData,
              size: 60.h,
            ),
            Text(
              numOfText.tr,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
