import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/profile_data.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';

abstract class OtherUserProfileController extends GetxController {
  backToHomeScreen();
  copyText(String text);
  getUserPets();
  //openPopUpPetInfo({required PetModel petModel});
  getUserPosts(String userId);
  openPopUpPetInfoFromPetlList({required PetModel petModel});
  openPopUpPetInfoFromPosts({required PetModel petModel, required int index});
}

class OtherUserProfileControllerImp extends OtherUserProfileController {
  String userId='';


  OtherUserProfileControllerImp(String userId) {
    // Constructor logic, if any
    this.userId = userId;
    _initialize(userId);
  }

  _initialize(String userId) {
    getUserPets();
    getUserPosts(userId);
  }
  MyServices myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<PetModel> userPetsListProfile = [];
  int selectedIndex = -1;
  List<PostModel> userPosts = [];
  @override
  backToHomeScreen() {
    Get.back();
  }



  @override
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "114".tr,
      '',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "114".tr,
        style: TextStyle(fontSize: 18.0.sp), // Adjust the font size as needed
      ),
    );
  }





  @override
  getUserPets() async {

    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData
        .getData(userId
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        userPetsListProfile.clear();
        userPetsListProfile
            .addAll(dataResponse.map((e) => PetModel.fromJson(e)));

      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
    print(userPetsListProfile);
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
  void onInit() {
    getUserPets();
    getUserPosts(userId);
    super.onInit();
  }



  @override
  getUserPosts(String userId) async {
    // TODO: implement getAllPosts
    statusRequest = StatusRequest.loading;
    update();
    var response = await profileData.getUserPosts(
        this.userId
    );
    //print(response[0]['data']);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response[0]['status'] == "success") {
        // print('successsss${response[0]['data']}');

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
  void openPopUpPetInfoFromPosts({required PetModel petModel, required int index}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel: userPosts[index].petModel!),
      ),
    );
  }
  @override
  void openPopUpPetInfoFromPetlList({required PetModel petModel}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel: userPetsListProfile[selectedIndex]),
      ),
    );
  }


}
