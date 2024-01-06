import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/show_bottom_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/profile_data.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';
import 'package:pet_connect/view/widgets/profile/choose_image_source_bottom_modal.dart';

abstract class ProfileController extends GetxController {
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  copyText(String text);
  saveProfileImgToSharedPref();
  uploadProfileImageToServer();
  goToAddPetScreen();
  getUserPets();
  openPopUpPetInfo({required PetModel petModel});
  refreshPage();
  removePet({required int index});
  getProfilePic();
}

class ProfileControllerImp extends ProfileController {
  File? myFile;
  MyServices myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<PetModel> userPetsListProfile = [];
  int selectedIndex = -1;

  //TEST
  var argData = Get.arguments['screenName'];
  //TEST
  @override
  backToHomeScreen() {
    Get.offNamed(AppRoute.homeScreen);
  }

  @override
  chooseImageFromCamera() async {
    // TODO: implement chooseImageFromCamera
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    myFile = File(xFile!.path);
    saveProfileImgToSharedPref();
    update();
  }

  @override
  chooseImageFromGallery() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    myFile = File(xFile!.path);
    saveProfileImgToSharedPref();
    update();
  }

  @override
  saveProfileImgToSharedPref() {
    if (myFile != null) {
      //TODO: upload image tp server
      uploadProfileImageToServer();
      getProfilePic();
    }
  }

  @override
  uploadProfileImageToServer() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData.postDataFile(
      myServices.sharedPreferences.getString("userID")!,
      myFile!,
    );
    print(
        "===========response PROFILE==================== Controller $response ");

    statusRequest = handlingData(response);
    print('Status Req--->  $statusRequest');
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        //TODO: SomeThing to do
        showBottomSnackBar(text: 'تم تحديث الصور بنجاح.');
      } else {
        //TODO: SomeThing to do
        showBottomSnackBar(text: 'حدث خطأ ما, يرجى المحاولة لاحقا.');
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "تم النسخ بنجاح",
      '',
      duration: const Duration(seconds: 2),
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

  @override
  getUserPets() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData
        .getData(myServices.sharedPreferences.getString("userID")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        userPetsListProfile.clear();
        userPetsListProfile
            .addAll(dataResponse.map((e) => PetModel.fromJson(e)));
      } else {
        showBottomSnackBar(text: 'حدث خطأ ما, يرجى المحاولة لاحقا.');
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  refreshPage() {
    getUserPets();
  }

  @override
  void openPopUpPetInfo({required PetModel petModel}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel: userPetsListProfile[selectedIndex]),
      ),
    );
  }

  @override
  goToAddPetScreen() {
    // TODO: implement goToAddPetScreen
    // Arguments
    Get.toNamed(AppRoute.addNewPetScreen);
  }

  @override
  void onInit() {
    getUserPets();
    //test
    print(argData);
    //test
    super.onInit();
  }

  @override
  removePet({required int index}) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData.removePet(
        myServices.sharedPreferences.getString("userID")!,
        userPetsListProfile[index].petID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        showBottomSnackBar(text: 'تم حذف الحيوان بنجاح.');
        refreshPage();
      } else {
        showBottomSnackBar(text: 'حدث خطأ ما, يرجى المحاولة لاحقا.');
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  getProfilePic() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData
        .getProfilePic(myServices.sharedPreferences.getString("userID")!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        myServices.sharedPreferences
            .setString("profilePic", response['data']['profilePic']);
        print('PROFILE ---> ${response['data']['profilePic']}');
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }
}
