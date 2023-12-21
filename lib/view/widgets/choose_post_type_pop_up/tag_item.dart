import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class TagItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback? onPressed;

 // TagItem({ this.iconPath, required this.text, this.onPressed},this.onPressed);
  const TagItem({super.key, required this.iconPath, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 98.h,
        width: 88.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.only(right: 2.0.w,left: 2.w),
              child: Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
              ),
            ),

            Container(
              height: 15.h,
              width: 93.w,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Text background color
                borderRadius: BorderRadius.circular(8.h), // Circular border radius
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: AppColor.black,fontSize: 10.sp), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}