import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';


class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.white,
      elevation: 0,
      shape: const CircleBorder(),
      child: Icon(
        Icons.add,
        size: 32.0.sp,
      ),
    );
  }
}
