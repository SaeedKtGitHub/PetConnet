import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';

class UserDataRow extends StatelessWidget {
  const UserDataRow({Key? key, required this.icon, required this.text})
      : super(key: key);
  final Icon icon;
  final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Row(
        children: [
          // The icon:
          Icon(
            icon.icon,
            size: 30.h, // Adjust the size as needed
            color: icon.color, // You can also include color if it's relevant
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          const Spacer(),
          // Copy icon
          GetBuilder<ProfileControllerImp>(
            init: ProfileControllerImp(),
            builder: (controller) => InkWell(
              onTap: () {
                controller.copyText(text);
              },
              child: Icon(
                Icons.copy,
                size: 24.0.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
