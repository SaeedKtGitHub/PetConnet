import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "لا يمكن ان يكون فارغ";
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "اسم المستخدم غير صحيح";
    }
  }
  if (type == "text") {
    // if (!GetUtils.isAlphabetOnly(val)) {
    //   return "العنوان غير صحيح";
    // }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "البريد الالكتروني غير صحيح";
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "رقم الهاتف غير صحيح";
    }
    if (val.substring(0, 3) != '077' ||
        val.substring(0, 3) != '078' ||
        val.substring(0, 3) != '079') {
      return "يجب ان يبدأ ب 077 او 078 او 079";
    }
  }

  if (val.length < min) {
    return "لا يمكن ان يكون اقل من $min";
  }

  if (val.length > max) {
    return "لا يمكن ان يكون اكبر من $max";
  }
}
