import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/color.dart';
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
import 'package:pet_connect/view/widgets/home/contact_info_popup.dart';
import 'package:pet_connect/view/widgets/pet_data_popup.dart';
import 'package:pet_connect/view/widgets/pop_up_chose_post_type.dart';

abstract class HomeController extends GetxController {
  getUserData();
  getAllPosts();
  goToAllArticlesScreen();
  goToDynamicScreen(String title, {required List<PostModel> posts, required String tag});
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
   openContactMeInfo(String username,String phone,String imagePath);
  copyText(String text);

}

class HomeControllerImp extends HomeController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  HomeScreenData homeScreenData = HomeScreenData(Get.find());
  UserModel currentUser = UserModel();
  List<PostModel> allPosts = [];
  List<PostModel> filteredPosts = [];
  final ScrollController _scrollController = ScrollController();
  List<PostModel> searchResults = [];
  bool isSearchingInHome = false;
  bool isSearchingInDynamic = false;

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
    ArticlesControllerImp articlesControllerImp=Get.find<ArticlesControllerImp>();
    articlesControllerImp.isSearching=false;
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
  goToDynamicScreen(String title, {required List<PostModel> posts,String? tag}) {
    // TODO:
    Get.to(() => DynamicViewScreen(title: title, posts: posts, tag: tag));
  }

  @override
  refreshPage() {
    // TODO: implement refresgPage
    getAllPosts();
  }
  resetSearchRefresh(){
    isSearchingInHome=false;
    isSearchingInDynamic=false;
    update();
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
     // Get.offNamed(AppRoute.profileScreen,arguments: {"screenName": "home"});
      Get.offNamed(AppRoute.profileScreen);
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
      resetSearchRefresh();
    }
  }
  void goToSettingsScreen() {
    if (Get.currentRoute != AppRoute.settingsScreen) {
      Get.offNamed(AppRoute.settingsScreen);
    }
    update();
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
  @override
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "تم النسخ بنجاح",
      '',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      titleText: Text(
        "تم النسخ بنجاح",
        style: TextStyle(fontSize: 18.0.sp), // Adjust the font size as needed
      ),
    );
  }
  @override
  openContactMeInfo(String username, String phone, String imagePath) {
    Get.dialog(
      Dialog(
        child:ContactInfoPopup(
            phone: phone,
            username: username,
            imagePath: imagePath,
             onCopyText:(){
               copyText(phone);
             },
        ),
      ),
    );
  }
  void resetSearch() {
    searchResults.clear();
    update();
  }
  @override
  void searchPosts(String query) {
    print('searchhhh $query');
    if (query.isEmpty) {
      // If the query is empty, show all posts
      if(Get.currentRoute==AppRoute.homeScreen){
        searchResults=allPosts.toList();
      }else {
        searchResults=filteredPosts.toList();//dynamic screen (Filters screens)

      }

    } else {
      // Filter posts based on the search query within the already filteredPosts
      searchResults.clear();
      if(Get.currentRoute==AppRoute.homeScreen){
        searchResults = allPosts
            .where((post) {
          bool contentMatch = post.content != null && post.content!.toLowerCase().contains(query.toLowerCase());
          bool breedMatch = post.petModel!.breed != null && post.petModel!.breed !.toLowerCase().contains(query.toLowerCase());
          return contentMatch || breedMatch ;
        })
            .toList();
      }
      else{//dynamic screen (Filters screens)
        searchResults = filteredPosts
            .where((post) {
          bool contentMatch = post.content != null && post.content!.toLowerCase().contains(query.toLowerCase());
          bool breedMatch = post.petModel!.breed != null && post.petModel!.breed !.toLowerCase().contains(query.toLowerCase());
          return contentMatch || breedMatch ;

        })
            .toList();
      }


    }

    update();
  }


    void  cancelSearch(){
      isSearchingInHome = false;
      isSearchingInDynamic=false;
      resetSearch();
      update();
}



}
