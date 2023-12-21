import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewSocialPostContainer extends StatelessWidget {
  const NewSocialPostContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 260.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0.h),
            child: Image.asset(
              'assets/images/popUp.jpg',
              fit: BoxFit.cover, // Ensure the image fully covers the Container
              width: 260.w, // Set width to match the Container's width
              height: 100.h, // Set height to match the Container's height
            ),
          ),
          Positioned(
            left: 16.w,
            top: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'منشور اجتماعي جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'ماذا يفعل حيوانك الأليف؟\nشارك معنا!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
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
