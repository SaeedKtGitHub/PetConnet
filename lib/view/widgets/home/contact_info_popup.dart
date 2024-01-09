import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile/OtherUserProfileImage.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';


class ContactInfoPopup extends StatelessWidget {
  const ContactInfoPopup({
    Key? key,
    required this.phone,
    required this.username,
    required this.imagePath,
    required this.onCopyText,
  }) : super(key: key);

  final String phone;
  final String username;
  final String imagePath;
  final void Function()? onCopyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Column(
        children: [
          // First row:
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImageAsset.cancel,
                  width: 43.0.w,
                  height: 43.0.h,
                ),
              ),
              SizedBox(width: 50.w),
              //the head:
              Text(
                '67'.tr,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          OtherUserProfileImage(imagePath:imagePath),
          Center(
            child: Text(
              username,
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right:60.0.w,left: 30.w),
            child: Row(
              children: [
                Center(
                  child: Text(
                    phone,
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.sp),
                  ),
                ),
                SizedBox(width: 20.w,),
                InkWell(
                  onTap: onCopyText,
                  child: Icon(
                    Icons.copy,
                    size: 24.0.h,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
