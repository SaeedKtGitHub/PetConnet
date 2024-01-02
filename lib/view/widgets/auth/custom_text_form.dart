import 'package:flutter/material.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomTextForm extends StatelessWidget {
   const CustomTextForm(
      {super.key,
      this.obscureText,
      this.onTapIcon,
      required this.hintText,
       this.labelText,
       this.iconData,
      required this.myController,
      required this.valid,
      required this.isNumber});

  final String hintText;
  final String? labelText;
   final IconData? iconData;
  final String? Function(String?) valid;
  final TextEditingController? myController;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        cursorColor: AppColor.primaryColor,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        obscureText: obscureText == null || obscureText == false ? false : true,
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
            label: labelText != null
                ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    labelText!,
                    style: const TextStyle(color: AppColor.primaryColor),
                  ),
            )
                : null,

            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(
                iconData,
                color: AppColor.primaryColor,
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),
      ),
    );
  }
}
