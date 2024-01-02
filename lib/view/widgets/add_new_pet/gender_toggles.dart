import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/view/widgets/add_new_pet/build_toggle_button_with_gender_icon.dart';

class GenderToggleButtons extends StatelessWidget {
  final List<bool> isSelected;
  final Function(int) onPressed;

  const GenderToggleButtons({super.key, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onPressed,
      fillColor: AppColor.primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      children: <Widget>[
        buildToggleButtonWithGender(label: '37'.tr, isSelected: isSelected[0]),
        buildToggleButtonWithGender(label: '36'.tr, isSelected: isSelected[1]),
      ],
    );
  }
}