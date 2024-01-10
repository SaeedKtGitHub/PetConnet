import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/show_bottom_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/profile_data.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/data/model/post_model.dart';
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
  getUserPosts();

  getProfilePic();
}

class ProfileControllerImp extends ProfileController {
  File? myFile;
  MyServices myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<PetModel> userPetsListProfile = [];
  int selectedIndex = -1;
  List<PostModel> userPosts = [];

  //TEST
  //var argData = Get.arguments['screenName'];
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
        showBottomSnackBar(text: '126'.tr);
      } else {
        //TODO: SomeThing to do
        showBottomSnackBar(text: '123'.tr);
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "114".tr,
      '',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      titleText: Text(
        "114".tr,
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
        showBottomSnackBar(text: '123'.tr);
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  refreshPage() {
    getUserPets();
    getUserPosts();
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
    getUserPosts();
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
        showBottomSnackBar(text: '122'.tr);
        refreshPage();
      } else {
        showBottomSnackBar(text: '123'.tr);
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

  @override
  getUserPosts() async {
    // TODO: implement getAllPosts
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData.getUserPosts(
        myServices.sharedPreferences.getString("userID")!,
    );
    print(response[0]['data']);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response[0]['status'] == "success") {
        print('successsss${response[0]['data']}');

        List dataResponse = response[0]['data'];
        // Clear the existing list before adding new items
        userPosts.clear();
        userPosts.addAll(dataResponse.map((e) => PostModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


  @override
  removePost(String postID) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData.removePost(
      myServices.sharedPreferences.getString("userID")!,
      postID,
    );

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.snackbar(
            "124".tr,
            '',
            backgroundColor: Colors.grey[500],
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "124".tr,
              style: TextStyle(fontSize: 16.0.sp),
            ));
        update();
        return true; // Indicate success
      } else {
        Get.snackbar(
            "125".tr,
            '',
            backgroundColor: Colors.grey[500],
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "124".tr,
              style: TextStyle(fontSize: 16.0.sp),
            ));
        statusRequest = StatusRequest.failure;
      }
      update();
      return false; // Indicate failure
    }
  }

}
