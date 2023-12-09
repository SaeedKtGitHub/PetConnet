import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70.h,
      notchMargin: 8.0.h,
      shape: const CircularNotchedRectangle(),
      color: AppColor.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          //اhome item
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 30.h,
              ),
              Text(
                "الرئيسية",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              )
            ],
          ),

          //gallery  item
          Padding(
            padding: EdgeInsets.only(left: 100.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                  size: 30.h,
                ),
                Text(
                  "المعرض",
                  style: TextStyle(color: AppColor.white, fontSize: 12.sp),
                )
              ],
            ),
          ),

          //اshop item
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: AppColor.white,
                size: 30.h,
              ),
              Text(
                "المتجر",
                style: TextStyle(color: AppColor.white, fontSize: 12.sp),
              )
            ],
          ),

          //settings item
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 30.h,
              ),
              Text(
                "إعدادات",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              )
            ],
          ),
        ],
      ),
    );
  }
}
