import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/view/widgets/profile/choose_image_source_bottom_modal.dart';

abstract class ProfileController extends GetxController {
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  copyText(String text);
  openPopUpPetInfo();
  getPets();
}

class ProfileControllerImp extends ProfileController {

  File? myFile;

  @override
  backToHomeScreen() {
    Get.back();
  }


  @override
  chooseImageFromCamera() async {
    // TODO: implement chooseImageFromCamera
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    myFile = File(xFile!.path);
    update();
  }

  @override
  chooseImageFromGallery() {
    // TODO: implement chooseImageFromGallery
    throw UnimplementedError();
  }

  @override
  getPets() {
    // TODO: implement getPets
    throw UnimplementedError();
  }

  @override
  openPopUpPetInfo() {
    // TODO: implement openPopUpPetInfo
    throw UnimplementedError();
  }


  @override
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "تم النسخ بنجاح",
      '',
      duration:const  Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "تم النسخ بنجاح",
        style: TextStyle(fontSize: 18.0.sp), // Adjust the font size as needed
      ),
    );
  }

  Future<int?> showImagePickerModal() async {
    return await showModalBottomSheet<int>(
      context: Get.context!,
      builder: (context) => const ImagePickerModal(),
    );
  }

  //The manager method (runs all the process)
  Future<int?> getImageSourceOption() async {
    int? selectedOption = await showImagePickerModal();
    if (selectedOption != null) {
      switch (selectedOption) {
        case 0:
          chooseImageFromCamera();
          break;
        case 1:
          chooseImageFromGallery();

          break;
        default:
          break;
      }
    }
    return selectedOption;
  }



}
