import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;
  final void Function()? onGalleryTap;
  final void Function()? onHomeTap;
  final void Function()? onSettingsTap;
  final void Function()? onProfieTap;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.onGalleryTap,
    required this.onHomeTap,
    required this.onSettingsTap,
    required this.onProfieTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60.h,
      notchMargin: 7.0.h,
      shape: const CircularNotchedRectangle(),
      color: AppColor.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          //اhome item
          GestureDetector(
            onTap: onHomeTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 24.h,

                ),
                Text(
                  "الرئيسية",
                  style: TextStyle(color: Colors.white, fontSize: 9.sp,
                  fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),

          //gallery  item
          GestureDetector(
            onTap:onGalleryTap,
            child: Padding(
              padding: EdgeInsets.only(left: 100.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 24.h,
                  ),
                  Text(
                    "المعرض",
                    style: TextStyle(color: AppColor.white, fontSize: 9.sp,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ),

          // profile item
          GestureDetector(
            onTap: onProfieTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_outline_outlined,
                  color: AppColor.white,
                  size: 24.h,
                ),
                Text(
                  "حسابي",
                  style: TextStyle(color: AppColor.white, fontSize: 9.sp,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),

          //settings item
          GestureDetector(
            onTap: onSettingsTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 24.h,
                ),
                Text(
                  "إعدادات",
                  style: TextStyle(color: Colors.white, fontSize: 9.sp,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
