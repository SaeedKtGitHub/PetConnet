import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "147".tr;
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "148".tr;
    }
  }
  if (type == "text") {
    // if (!GetUtils.isAlphabetOnly(val)) {
    //   return "العنوان غير صحيح";
    // }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "149".tr;
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "150".tr;
    }
    if (val.substring(0, 3) != '077' ||
        val.substring(0, 3) != '078' ||
        val.substring(0, 3) != '079') {
      return "151".tr;
    }
  }

  if (val.length < min) {
    return "${'152'.tr}$min";
  }

  if (val.length > max) {
    return "${'153'.tr}$max";
  }
}
