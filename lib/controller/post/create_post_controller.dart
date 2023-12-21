import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/core/constant/routes.dart';

abstract class CreatePostController extends GetxController {
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  replaceWidgetsWithImage();
  removeImage();
  goToAddPetScreen();
  openPopUpPetInfo(); // CreatePostData
  onLongPressOnItem();
  getPets(); // CreatePostData
  addPost(); // CreatePostData
}

class CreatePostControllerImp extends CreatePostController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? myFile;
  late TextEditingController address;
  bool isShowImage = false;
  // bool isLoading = false;

  @override
  backToHomeScreen() {
    Get.offNamed(AppRoute.homeScreen);
  }

  @override
  chooseImageFromCamera() async {
    // TODO: implement chooseImageFromCamera
    // isLoading = true;
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    myFile = File(xFile!.path);
    replaceWidgetsWithImage();
    // isLoading = false;
    update();
  }

  @override
  chooseImageFromGallery() async {
    // TODO: implement chooseImageFromGallery
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    myFile = File(xFile!.path);
    replaceWidgetsWithImage();
    update();
    // try {
    //   XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   myFile = File(xFile!.path);
    //   replaceWidgetsWithImage();
    //   update();
    // } catch (e) {
    //   var status = await Permission.photos.status;
    //   if (status.isDenied) {
    //     print('access denied');
    //     Get.showSnackbar(const GetSnackBar(
    //       title: 'Permission',
    //       message: 'Access Permission Denied',
    //       duration: Duration(seconds: 2),
    //     ));
    //   }
    // }
  }

  @override
  replaceWidgetsWithImage() {
    if (myFile != null) {
      isShowImage = true;
    } else {
      isShowImage = false;
    }
  }

  @override
  removeImage() {
    myFile = null;
    replaceWidgetsWithImage();
    update();
  }

  @override
  goToAddPetScreen() {
    // TODO: implement goToAddPetScreen
  }

  @override
  openPopUpPetInfo() {
    // TODO: implement openPopUpPetInfo
  }

  @override
  onLongPressOnItem() {
    // TODO: implement onLongPressOnItem
  }

  @override
  getPets() {
    // TODO: implement getPets
  }

  @override
  addPost() {
    // TODO: implement addPost
  }

  @override
  void onInit() {
    address = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    address.dispose();
    super.dispose();
  }
}
