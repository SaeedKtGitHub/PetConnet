import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class DatePickerButton extends StatelessWidget {
   const DatePickerButton({Key? key,
    required this.onPressed,
    required this.text
  }) : super(key: key);
 final  void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
        onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:AppColor.primaryColor , // Replace with your AppColor.primaryColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            //controller.getSelectedDate()!,
            style: TextStyle(color: AppColor.black,
              fontSize: 15.sp,
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.white,size: 25.h,),
        ],
      ),
    );
  }
}
