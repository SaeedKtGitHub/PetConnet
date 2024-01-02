import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/functions/show_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/post/create_post_data.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';

abstract class CreatePostController extends GetxController {
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  replaceWidgetsWithImage();
  removeImage();
  goToAddPetScreen(); //TODO: wait this screen to finish.
  openPopUpPetInfo({required PetModel petModel}); // CreatePostData
  onLongPressOnItem({required int index});
  getUserPets(); // CreatePostData
  addPost(); // CreatePostData
  getTagFromPopUp({required int index});
  refreshPage();
}

class CreatePostControllerImp extends CreatePostController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? myFile;
  late TextEditingController content;
  late TextEditingController price;
  late TextEditingController phone;
  bool isShowImage = false;
  int selectedIndex = -1;
  int indexTag = -1;
  String myTag = "";
  StatusRequest statusRequest = StatusRequest.none;
  List<PetModel> userPetsListCreate = [];
  // bool isLoading = false;
  CreatePostData createPostData = CreatePostData(Get.find());
  MyServices myServices = Get.find();
  @override
  backToHomeScreen() {
    Get.delete<CreatePostControllerImp>();
    Get.offNamed(AppRoute.homeScreen);
  }
  HomeControllerImp homeControllerImp=Get.put(HomeControllerImp());

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
    Get.toNamed(AppRoute.addNewPetScreen);
  }

  // @override
  // openPopUpPetInfo({required int index}) {
  //   // TODO: implement openPopUpPetInfo
  //   //                    one model of pet
  //   //CustomPopUpPetInfo(userPetsList[index])//
  // }
  @override
  void openPopUpPetInfo({required PetModel petModel}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel: userPetsListCreate[selectedIndex]),
      ),
    );
  }

  @override
  onLongPressOnItem({required int index}) {
    // TODO: implement onLongPressOnItem

    selectedIndex = index;
    //print(selectedIndex);
    update();
  }

  @override
  getUserPets() async {
    print('hiiiiiiiiiiiiii');
    // TODO: implement getPets
    statusRequest = StatusRequest.loading;
    update();
    // print(
    //     'SHRED ---> ID -->  ${myServices.sharedPreferences.getString("userID")!}');
    var response = await createPostData
        .getData(myServices.sharedPreferences.getString("userID")!);
    // print("===========HASSAN==================== Controller $response ");
    statusRequest = handlingData(response);

    // print("===========HASSAN2==================== Controller $response ");
    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        userPetsListCreate.clear();
        userPetsListCreate
            .addAll(dataResponse.map((e) => PetModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  addPost() async {
    //if no image of post
    if (myFile == null) {
      return showSnackBar(numOfText1: '23', numOfText2: '24');
    }
    // if no pet addedd
    if (userPetsListCreate.isEmpty) {
      return showSnackBar(numOfText1: '23', numOfText2: '26');
    }
    //if no selected pet by (onLongPress)
    if (selectedIndex == -1) {
      return showSnackBar(numOfText1: '23', numOfText2: '27');
    }
    // print('UUUUUUUUUUUUUUU -->  ${userPetsList[selectedIndex].petID}');
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response;
      //start
      if (myTag == "trading") {
        response = await createPostData.postDataFile(
          myServices.sharedPreferences.getString("userID")!,
          content.text,
          userPetsListCreate[selectedIndex].petID!,
          myTag,
          price: price.text,
          myFile!,
        );
      } else {
        response = await createPostData.postDataFile(
          myServices.sharedPreferences.getString("userID")!,
          content.text,
          userPetsListCreate[selectedIndex].petID!,
          myTag,
          myFile!,
        );
        print('in else block');
      }

      // print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      //print("=======================Con" + response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // print('ADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
          Get.delete<CreatePostControllerImp>();
          homeControllerImp.refreshPage();
          Get.offNamed(AppRoute.homeScreen);
        } else {
          showSnackBar(numOfText1: '23', numOfText2: '25');
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    } else {}
  }

  @override
  getTagFromPopUp({required int index}) {
    indexTag = index;
    myTag = getValueAtIndex(indexTag);
  }

  //TEST
  @override
  refreshPage() {
    getUserPets();
  }

  //TEST
  @override
  void onInit() {
    content = TextEditingController();
    price = TextEditingController();
    phone = TextEditingController();
    getUserPets();
    super.onInit();
  }

  @override
  void dispose() {
    content.dispose();
    price.dispose();
    phone.dispose();
    super.dispose();
  }
}
