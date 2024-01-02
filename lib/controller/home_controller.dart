
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/home/home_screen_data.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/data/model/user_model.dart';
import 'package:pet_connect/view/screens/dynamic_view_screen.dart';
import 'package:pet_connect/view/widgets/home/build_image_with_text.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';
import 'package:pet_connect/view/widgets/pop_up_chose_post_type.dart';

abstract class HomeController extends GetxController {
  getUserData();
  getAllPosts();
  //goToAllPostScreen();
  goToAllArticlesScreen();
  goToDynamicScreen(String title,{required List<PostModel> posts});
  refreshPage();
  getFilteredPosts({required String tag,});
  scrollToTop();
  // goToSettingsScreen();
  // goToHomeScreen();
  // goToGallery();
}

class HomeControllerImp extends HomeController {


  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  HomeScreenData homeScreenData = HomeScreenData(Get.find());
  UserModel currentUser = UserModel();
  List<PostModel> allPosts = [];
  List<PostModel> filteredPosts = [];
  final ScrollController _scrollController = ScrollController();


  ScrollController get scrollController => _scrollController;

  List<Widget> slider_articles_widgets(List images) {
    List<Widget> list = [];

    for (int i = 0; i < images.length; i++) {
      list.add(
          BuildImageWithText(
              imagePath: slides[i].imagepath,
              text: slides[i].slideText));
    }
    return list;
  }

  int currentSliderIndex = 0;

  setCurrentSliderIndex(index) {
    currentSliderIndex = index;
  }

  int currentNavIndex = 0;


  void onItemTapped(int index) {
    update();
    currentNavIndex = index;
  }

  void showChoosePostTypePopUp() {
    Get.dialog(
      const Dialog(
        child: ChoosePostTypePopUp(),
      ),
    );
  }

  //Back to home when cancelling Add post pop up (from FAB)
  void backToHome() {
    Get.back();
  }

  @override
  getAllPosts() async {
    // TODO: implement getAllPosts
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeScreenData
        .getAllPosts(myServices.sharedPreferences.getString("userID")!,);
    //print('iddddddddddidid${myServices.sharedPreferences.getString("userID")!}');
    statusRequest = handlingData(response);
     //  print(response);
   // print('[pOSTSSSSSSSSSSS::::: ${response[0]['data']}////////////////');
    if (StatusRequest.success == statusRequest) {
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        allPosts.clear();
        allPosts.addAll(dataResponse.map((e) => PostModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getFilteredPosts({required String tag}) async {
    // TODO: implement getAllPosts
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeScreenData
        .getPostsByTag(myServices.sharedPreferences.getString("userID")!,
      tag: tag
    );
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        // Clear the existing list before adding new items
        filteredPosts.clear();
        filteredPosts.addAll(dataResponse.map((e) => PostModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    print(filteredPosts.length);
    update();
  }




  @override
  getUserData() async {
    // TODO: implement getPets
    statusRequest = StatusRequest.loading;
    update();
    // print(
    //     'SHRED ---> ID -->  ${myServices.sharedPreferences.getString("userID")!}');
    var response = await homeScreenData
        .getUser(myServices.sharedPreferences.getString("userID")!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Map<String, dynamic> dataResponse = response['data'];
        currentUser = UserModel.fromJson(dataResponse);
      }
      else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  @override
  goToAllArticlesScreen() {
    // TODO: implement goToAllArticlesScreen
    Get.toNamed(AppRoute.articlesScreen);
  }



  @override
  void onInit() {
    // TODO: implement onInit
     getUserData();
     getAllPosts();
    super.onInit();
  }

  @override
  goToDynamicScreen(String title,{required List<PostModel> posts}) {
    // TODO:
    Get.to(()=>DynamicViewScreen(title:title , posts:posts));
  }


  @override
  refreshPage() {
    // TODO: implement refresgPage
    getAllPosts();
  }
  @override
  void openPopUpPetInfo({required PetModel petModel,required int index}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel:allPosts[index].petModel!),
      ),
    );
  }

  @override
  void scrollToTop() {
    _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }




}

