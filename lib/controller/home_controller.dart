import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/home/home_screen_data.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/data/model/user_model.dart';
import 'package:pet_connect/view/screens/comments_screen.dart';
import 'package:pet_connect/view/screens/dynamic_view_screen.dart';
import 'package:pet_connect/view/screens/other_user_profile_screen.dart';
import 'package:pet_connect/view/widgets/home/build_image_with_text.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';
import 'package:pet_connect/view/widgets/pop_up_chose_post_type.dart';

abstract class HomeController extends GetxController {
  getUserData();
  getAllPosts();
  goToAllArticlesScreen();
  goToDynamicScreen(String title, {required List<PostModel> posts});
  refreshPage();
  getFilteredPosts({
    required String tag,
  });
  scrollToTop();
  // goToSettingsScreen();
  // goToHomeScreen();
  // goToGallery();
  goToProfilePage();
 // removePost({required int index});
  goToOtherProfilePage(String userId,String userProfilePath,String username);
  likeOrDislikePost(String postId);

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
      list.add(BuildImageWithText(
          imagePath: slides[i].imagepath, text: slides[i].slideText));
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
    var response = await homeScreenData.getAllPosts(
      myServices.sharedPreferences.getString("userID")!,
    );
    statusRequest = handlingData(response);
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
    var response = await homeScreenData.getPostsByTag(
        myServices.sharedPreferences.getString("userID")!,
        tag: tag);
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
      } else {
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
  goToDynamicScreen(String title, {required List<PostModel> posts}) {
    // TODO:
    Get.to(() => DynamicViewScreen(title: title, posts: posts));
  }

  @override
  refreshPage() {
    // TODO: implement refresgPage
    getAllPosts();
  }

  @override
  void openPopUpPetInfo({required PetModel petModel, required int index}) {
    Get.dialog(
      Dialog(
        child: AnimalDataPopup(petModel: allPosts[index].petModel!),
      ),
    );
  }

  @override
  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  goToProfilePage() {
    // TODO: implement goToProfilePage
    if (Get.currentRoute != AppRoute.profileScreen) {
      Get.offNamed(AppRoute.profileScreen,arguments: {"screenName": "home"});
    }
  }


  @override
  removePost(String postID) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeScreenData.removePost(
      myServices.sharedPreferences.getString("userID")!,
      postID,
    );

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.snackbar(
            "تم حذف المنشور بنجاح",
            '',
            backgroundColor: Colors.grey[500],
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "تم حذف المنشور بنجاح",
              style: TextStyle(fontSize: 16.0.sp),
            ));
            update();
        return true; // Indicate success
      } else {
        Get.snackbar(
            "لم يتم حذف المنشور,حاول مرة أخرى",
            '',
            backgroundColor: Colors.grey[500],
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "تم حذف المنشور بنجاح",
              style: TextStyle(fontSize: 16.0.sp),
            ));
        statusRequest = StatusRequest.failure;
      }
      update();
      return false; // Indicate failure
    }
  }


  @override
  openCommentsScreen(List<CommentModel> commentsList) {
    // TODO: implement openCommentsScreen
     CommentsControllerImp commentsControllerImp=Get.find<CommentsControllerImp>();
    Get.dialog(
      Dialog(
        child: CommentsScreen(comments: commentsList,
           ),
      ),
    );
  }

  @override
  goToOtherProfilePage(String userId,String userProfilePath,String username) {
    // TODO: implement goToOtherProfilePage
    Get.to(()=>OtherUserProfileScreen(userId: userId,
        userProfilePath: userProfilePath,
        username: username));
  }

  // Method to scroll to the top
  void scrollToTopOrGoHome() {
    if (Get.currentRoute == AppRoute.homeScreen) {
      // Scroll to the top logic here
      scrollToTop();
    } else {
      // Go to home screen
      Get.offNamed(AppRoute.homeScreen);
    }
  }
  void goToSettingsScreen() {
    if (Get.currentRoute != AppRoute.settingsScreen) {
      Get.offNamed(AppRoute.settingsScreen);
    }
  }

  @override
  likeOrDislikePost(String postId) async {
    print('started likeeeeeeeee//////////////');
    // TODO: implement likeOrDislikePost
    // statusRequest = StatusRequest.loading;
    // update();
    var response = await homeScreenData.likeOrDislike(
      //TODO : CHANGE
        myServices.sharedPreferences.getString("userID")!,
        postId,
    );
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        print('likeeeeeeeeeeeeeee');
        update();
        return true;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
    return false;

  }

}
