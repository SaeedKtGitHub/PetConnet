import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField(
      {super.key,

        required this.hintText,
        this.iconData,
        required this.myController,
        required this.valid,
        required this.isNumber});

  final String hintText;
  final IconData? iconData;
  final String? Function(String?) valid;
  final TextEditingController? myController;
  final bool isNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: 215.w,      //margin: const EdgeInsets.only(bottom: 2),
      child: TextFormField(

        cursorColor: AppColor.primaryColor,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: myController,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),
      ),
    );
  }
}
