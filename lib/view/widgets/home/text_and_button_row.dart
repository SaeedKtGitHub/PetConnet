import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/view/widgets/home/arrow_left_button.dart';

class TextAndButtonRow extends StatelessWidget {
  const TextAndButtonRow({Key? key,
  required this.text,
    required this.onPressed
  }) : super(key: key);
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: 23.0.w),
      child: Row(
        children: [
          Text(
            // "آخر مقالات وأخبار الحيوانات الأليفة!",
            text,
            //textDirection: TextDirection.rtl,
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          // SizedBox(
          //   width: 22.w,
          // ),
          const Spacer(),
          //CustomButton(onPressed: () {}, buttonText: 'جميع المقالات'),
          ArrowLeftButton(onPressed: onPressed),
        ],
      ),
    );
  }
}
