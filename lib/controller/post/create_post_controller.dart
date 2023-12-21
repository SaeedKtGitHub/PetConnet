import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/show_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/auth/post/create_post_data.dart';

abstract class CreatePostController extends GetxController {
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  replaceWidgetsWithImage();
  removeImage();
  goToAddPetScreen(); //TODO: wait this screen to finish.
  openPopUpPetInfo(); // CreatePostData
  onLongPressOnItem({required int index});
  getPets(); // CreatePostData
  addPost(); // CreatePostData
}

class CreatePostControllerImp extends CreatePostController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? myFile;
  late TextEditingController address;
  bool isShowImage = false;
  int selectedIndex = -1;
  String petName = "";
  StatusRequest? statusRequest = StatusRequest.none;

  // bool isLoading = false;

  CreatePostData createPostData = CreatePostData(Get.find());
  MyServices myServices = Get.find();
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
    // TODO: Ask permission
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
  onLongPressOnItem({required int index}) {
    // TODO: implement onLongPressOnItem

    selectedIndex = index;
    print(selectedIndex);
    update();
  }

  @override
  getPets() {
    // TODO: implement getPets
  }

  @override
  addPost() async {
    // TODO: implement addPost
    if (myFile == null) {
      showSnackBar(numOfText1: '23', numOfText2: '24');
    }

    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await createPostData.postDataFile(
        myServices.sharedPreferences.getString("id")!,
        address.text,
        myFile!,
      );
      statusRequest = handlingData(response);
      //print("=======================Con" + response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoute.homeScreen);
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
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
