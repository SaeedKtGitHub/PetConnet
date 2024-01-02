import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class buildToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  const buildToggleButton({super.key,required this.label,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Text(
        label,
        style: const TextStyle(
          //color: isSelected ? AppColor.black : AppColor.primaryColor,
            color: AppColor.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
