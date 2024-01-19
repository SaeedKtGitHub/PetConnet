import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  getCurrentLocation();
}

class CreatePostControllerImp extends CreatePostController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? myFile;
  late TextEditingController content;
  late TextEditingController price;
  late TextEditingController phone;
  bool isShowImage = false;
  bool isHasLocation = false;
  String address = '';
  int selectedIndex = -1;
  int indexTag = -1;
  String myTag = "";
  StatusRequest statusRequest = StatusRequest.none;
  List<PetModel> userPetsListCreate = [];
  // bool isLoading = false;
  CreatePostData createPostData = CreatePostData(Get.find());
  MyServices myServices = Get.find();
  // @override
  // backToHomeScreen() {
  //   print("delete the bitaaaaaaaaaaaaaaa");
  //  //Get.delete<CreatePostControllerImp>();
  //   //myFile=null;
  //   Get.offNamed(AppRoute.homeScreen);
  //   Get.back();
  //
  //   //CreatePostControllerImp createPostControllerImp=Get.put(CreatePostControllerImp());
  //   // myFile=null;
  //   // Get.offNamed(AppRoute.homeScreen);
  //   //Get.back();
  // }
  @override
  backToHomeScreen() {
    //Get.delete<CreatePostControllerImp>();
    isShowImage = false;
    selectedIndex = -1;
    content.clear();
    price.clear();
    phone.clear();
    isHasLocation = false;
    Get.offNamed(AppRoute.homeScreen);
  }

  HomeControllerImp homeControllerImp = Get.put(HomeControllerImp());

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
    Get.toNamed(AppRoute.addNewPetScreen, arguments: {"screenName": "create"});
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
    print(
        "CreatePostControllerImp registered: ${Get.isRegistered<CreatePostControllerImp>()}");
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
    if (isHasLocation == false) {
      return showSnackBar(numOfText1: '23', numOfText2: '88');
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
        //print('in else block');
      }

      // print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      //print("=======================Con" + response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // print('ADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
          homeControllerImp.refreshPage();
          Get.offNamed(AppRoute.homeScreen);
          isShowImage = false;
          selectedIndex = -1;
          content.clear();
          price.clear();
          phone.clear();
          isHasLocation = false;
          // Get.delete<CreatePostControllerImp>();
        } else {
          showSnackBar(numOfText1: '23', numOfText2: '25');
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    } else {}
    update();
  }

  @override
  getTagFromPopUp({required int index}) {
    indexTag = index;
    myTag = getValueAtIndex(indexTag);
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

  @override
  getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    getAddressFromLatLang(position);
    isHasLocation = true;
    update();
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address = 'Address: ${place.street},${place.locality},${place.country}';
    update();
  }
}
