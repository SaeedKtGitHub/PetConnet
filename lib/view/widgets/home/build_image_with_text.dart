import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildImageWithText extends StatelessWidget {
  final String imagePath;
  final String text;

  const BuildImageWithText({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0.h),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 170.h,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin:  EdgeInsets.only(bottom: 16.h),
          width: double.infinity,
         // color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
          child: Text(
            text,
            style:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
