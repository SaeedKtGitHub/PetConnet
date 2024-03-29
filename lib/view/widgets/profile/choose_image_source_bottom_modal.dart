import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImagePickerModal extends StatelessWidget {
  const ImagePickerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0.h,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title:  Text('145'.tr),
            onTap: () {
              Get.back(result: 0); // Return 0 for camera
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title:  Text('146'.tr),
            onTap: () {
              Get.back(result: 1); // Return 1 for gallery
            },
          ),
        ],
      ),
    );
  }
}
