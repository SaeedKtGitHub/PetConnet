import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoImagesRow extends StatelessWidget {
  const TwoImagesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Padding(
          padding:  EdgeInsets.only(right: 10.0.w,left: 10.w),
          child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0.h),
                      child: Image.asset(
                        'assets/images/pets2.jpeg',
                        width: 165.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0.h),
                      child: Image.asset(
                        'assets/images/pets1.jpeg',
                        width: 165.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]),
        ),

    );


  }
}
