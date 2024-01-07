
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile/profile_controller.dart';
import 'package:pet_connect/link_api.dart';

class OtherUserProfileImage extends StatelessWidget {
  const OtherUserProfileImage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileControllerImp());

    return Container(
      width: 175.0.w,
      height: 175.0.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[200]!,
          width: 5.0.h,
        ),
        color: Colors.white,
      ),
      child: Center(
        child: imagePath.isNotEmpty
            ? SizedBox(
          width: 170.0.w,
          height: 170.0.h,
          child: CircleAvatar(
            radius: 80.0.h,
            backgroundColor: Colors.transparent,
            backgroundImage: Image.network(
              "${AppLink.linkImageRoot}/$imagePath",
            ).image, // Use .image to get ImageProvider from Image.network
          ),
        )
            : CircleAvatar(
          radius: 80.0.h,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.person_outline,
            size: 125.0.h,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
