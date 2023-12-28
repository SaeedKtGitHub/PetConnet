import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(vertical: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColor.primaryColor,
        textColor: AppColor.backgroundColorWhite,
        child: Text(
          text,
          style:  TextStyle(fontSize: 20.sp),
        ),
      ),
    );
  }
}
