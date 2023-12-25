import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/widgets/profile/custom_profile_image.dart';

class ProfileImage extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileImage({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();

    String filePath = myServices.sharedPreferences.getString('myFile') ?? '';
    Get.put(ProfileControllerImp);
    return GetBuilder<ProfileControllerImp>(
      builder: (controller) => Stack(
        children: [
          //The profile image container
          Container(
            width: 175.0.w, // Adjust as needed
            height: 175.0.h, // Adjust as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[200]!,
                width: 5.0.h,
              ),
              color: Colors.white,
            ),
            child: Center(
              child: filePath.isNotEmpty
                  //filePath.isNotEmpty
                  ? CustomProfileImage(
                      imageFile: File(filePath),
                    )
                  : CircleAvatar(
                      radius: 80.0.h, // Adjust as needed
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person_outline,
                        size: 125.0.h,
                        color: Colors.yellow,
                      ),
                    ),
            ),
          ),

          //The camera container
          Positioned(
            left: 8.0.w,
            bottom: 8.0.h,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 40.0.w,
                height: 40.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColor.black,
                    size: 25.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
