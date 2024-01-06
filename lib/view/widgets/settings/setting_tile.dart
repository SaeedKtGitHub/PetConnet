import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTile extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SettingTile({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
      child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300], // Gray background color
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward), // Left arrow at the end
            ),
          )),
    );
  }
}
