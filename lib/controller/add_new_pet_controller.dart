
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/functions/show_snack_bar.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/add_pet_screen_data.dart';

abstract class AddNewPetController extends GetxController{
  backToHomeScreen();
  chooseImageFromCamera();
  chooseImageFromGallery();
  replaceWidgetsWithImage();
  removeImage();
  presentDatePicker(BuildContext context);
  addPet();
  back();

}

class AddNewPetControllerImp extends AddNewPetController {
  File? myFile;
  bool isShowImage = false;
  //toggles of animal types
  List<bool> isSelectedPetType = [false, true, false,false];
  List<bool> isSelectedPetGender = [true, false];
  String _selectedGender='f';

  String get selectedGender => _selectedGender;

  set selectedGender(String value) {
    _selectedGender = value;
  } //default value

  String _selectedPet='cat';//default value

  String get selectedPet => _selectedPet;

  setSelectedPet(String value) {
    _selectedPet = value;
  }

  Map<int,String>  petsToggles = {
    0: "dog",
    1: "cat",
    2: "bird",
    3: "other",
  };
  //determine the pet type  depending on the index
  String getAnimalType(int index){
    return petsToggles[index]!;
  }

  setSelectedGenderPet(String value) {
    _selectedGender = value;
  }

  Map<int,String>  genderToggles = {
    0: "f",
    1: "m",
  };
  //determine the pet gender depending on the index
  String getAnimalGender(int index){
    return genderToggles[index]!;
  }

  DateTime? _selectedDate;
  //That is the wanted date as String
  String  getSelectedDate (){
    return formatDateTimeToString(_selectedDate);
  }
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController breed;
  late TextEditingController favName;
  StatusRequest? statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  AddNewPetData addNewPetDataData = AddNewPetData(Get.find());


  @override
  backToHomeScreen() {
    // TODO: implement backToHomeScreen
    throw UnimplementedError();
  }

  @override
  chooseImageFromCamera() async {
    // TODO: implement chooseImageFromCamera
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    myFile = File(xFile!.path);
    replaceWidgetsWithImage();
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
  removeImage() {
    myFile = null;
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
  //set the toggle buttons values,the index(which is the selected toggle) will be true and the other will be false
  List<bool> setValues(List<bool> isSelected,int index){

    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
    }

    return isSelected;
  }

  onPetTypeTogglePress(int index){
    isSelectedPetType=setValues(isSelectedPetType, index);
    setSelectedPet(getAnimalType(index));
    update();
  }
  onPetGenderTogglePress(int index){
    isSelectedPetGender=setValues(isSelectedPetGender, index);
    setSelectedGenderPet(getAnimalGender(index));
    update();
  }

  @override
  Future<DateTime?> presentDatePicker(BuildContext context) async {
    // Set the initial date to a default value relevant to pet birthdates
    final initialDate = DateTime(DateTime.now().year - 30, 1, 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year, initialDate.month, initialDate.day),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
        _selectedDate = pickedDate;
        update();
    }
    return null;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    breed = TextEditingController();
    favName = TextEditingController();
    super.onInit();
  }

  @override
  addPet() async {

    print('hooooo');
    //Check if there is image
    if (myFile == null) {
      return showSnackBar(numOfText1: '23', numOfText2: '45');
    }
    //Check if there is birthdate
    if (_selectedDate == null) {
      return showSnackBar(numOfText1: '23', numOfText2: '46');
    }



    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await addNewPetDataData.postPetData(
        //TODO : CHANGE
         myServices.sharedPreferences.getString("userID")!,
          favName.text,
        _selectedPet,
        breed.text,
        _selectedGender,
        getSelectedDate(),
        myFile!

      );
     // print('dont knowwwww${response}');
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          print('sucessss${response['data']}');
          Get.offAndToNamed(AppRoute.createPostScreen);
        } else {
          showSnackBar(numOfText1: '23', numOfText2: '25');
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  back() {
    Get.back();
    }
  @override
  void dispose() {
    breed.dispose();
    favName.dispose();
  }

}
