import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/routes.dart';

class NewSocialPostContainer extends StatelessWidget {
  const NewSocialPostContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    CreatePostControllerImp createController =
        Get.find<CreatePostControllerImp>();

    return InkWell(
      onTap: () {
        createController.getTagFromPopUp(index: 4);
        Get.back();
        Get.toNamed(AppRoute.createPostScreen);
      },
      child: SizedBox(
        height: 100.h,
        width: 260.w,
        child: Stack(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10.0.h),
            //   child: Image.asset(
            //     'assets/images/popUp.jpg',
            //     fit:
            //         BoxFit.cover, // Ensure the image fully covers the Container
            //     width: 260.w, // Set width to match the Container's width
            //     height: 100.h, // Set height to match the Container's height
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(
                    10), // Adjust the value for the desired roundness
              ),
              // Add any child widgets or content here if needed
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'منشور اجتماعي جديد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'ماذا يفعل حيوانك الأليف؟\nشارك معنا!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
