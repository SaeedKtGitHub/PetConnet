
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/view/widgets/add_new_pet/pet_toggle.dart';

class PetsTypesToggleButtons extends StatelessWidget {
  final List<bool> isSelected;
  final Function(int) onPressed;

  PetsTypesToggleButtons({required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onPressed,
      fillColor: AppColor.primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      children: <Widget>[
        buildToggleButton(label: '31'.tr, isSelected: isSelected[0]),
        buildToggleButton(label: '32'.tr, isSelected: isSelected[1]),
        buildToggleButton(label: '33'.tr, isSelected: isSelected[2]),
        buildToggleButton(label: '34'.tr, isSelected: isSelected[3]),
      ],
    );
  }
}