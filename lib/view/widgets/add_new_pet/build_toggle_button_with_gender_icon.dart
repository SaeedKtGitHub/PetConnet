import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class buildToggleButtonWithGender extends StatelessWidget {
  final String label;
  final bool isSelected;
  const buildToggleButtonWithGender({super.key,required this.label,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  //color: isSelected ? AppColor.black : AppColor.primaryColor,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Icon(
                label=='أنثى' || label== 'female'?
                Icons.female_outlined
                    :
                Icons.male_outlined,
                size: 25.h,
              ),
            ],
          ),

        );
  }
}
