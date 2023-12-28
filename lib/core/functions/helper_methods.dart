

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:intl/intl.dart';

String formattedDate(String isoDateString) {
  DateTime dateTime = DateTime.parse(isoDateString);
  String formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  return formattedDate;
}

String calculateAge(String birthDate) {
  DateTime today = DateTime.now();
  DateTime parsedBirthDate = DateTime.parse(birthDate);

  int age = today.year - parsedBirthDate.year;

  // Check if the birthday has occurred this year
  if (today.month < parsedBirthDate.month ||
      (today.month == parsedBirthDate.month && today.day < parsedBirthDate.day)) {
    age--;
  }

  // Format the age as desired
  String ageString = '$age سنوات';

  return ageString;
}

IconData getIconGender({required String gender}){
  gender=gender.toLowerCase();
  if(gender=="m"){
    return Icons.male_outlined;
  }
  return Icons.female_outlined;
}

Image getIconPetType(String type) {
  Map<String, Image> data = {
    'dog': Image.asset(AppImageAsset.dog),
    'cat': Image.asset(AppImageAsset.cat),
    'bird': Image.asset(AppImageAsset.bird),
  };
  // Retrieve the image based on the given type
  Image? selectedImage = data[type];

  // Return a default image if the type is not found
  return selectedImage ?? Image.asset(AppImageAsset.dog);
}
//taks DateTime object and convert it to  yyyy-MM-dd format
String formatDateTimeToString(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } else {
    return '39'.tr;
  }
}








