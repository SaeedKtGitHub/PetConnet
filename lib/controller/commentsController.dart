import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/functions/handling_data_controller.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/datasource/remote/post/comments_data.dart';
import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/view/screens/comments_screen.dart';


abstract class CommentsController extends GetxController {

  openCommentsScreen(List<CommentModel> commentsList,String postId) ;
  addComment(String postID);
  deleteComment(String postID,String commentId);
}

class CommentsControllerImp extends CommentsController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController comment;
  StatusRequest statusRequest = StatusRequest.none;
  CommentsData commentsData = CommentsData(Get.find());
  MyServices myServices = Get.find();
  List<CommentModel> comments=[];
  RxString currentPostId = RxString('');
  String get getCurrentPostId => currentPostId.value;
  // Add a method to set comments
  void setComments(List<CommentModel> commentsList) {
    comments = commentsList;
    update();
  }
  void setCurrentPostId(String postId) {
    currentPostId.value = postId;
  }
  @override
  openCommentsScreen(List<CommentModel> commentsList,String postId) {
    // TODO: implement openCommentsScreen
    //HomeControllerImp homeControllerImp=Get.find<HomeControllerImp>();
    getComments(postId);
    Get.dialog(
      Dialog(
        child: CommentsScreen(comments: commentsList,
         ),
      ),
    );
  }

@override
  void onInit() {
    // TODO: implement onInit
    comment=TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    comment.dispose();
  }

  @override
  addComment(String postID)async  {
    //Check if the comment is not empty
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await commentsData.postCommentData(
        //TODO : CHANGE
        myServices.sharedPreferences.getString("userID")!,
          postID,
          comment.text
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // Clear the existing list before adding new items
          comments.clear();
          comment.clear();//clear the comment text controller
          await getComments(postID);//refresh the comments screen
          return true;
        } else {
          statusRequest = StatusRequest.failure;
        }
      }

    }
    comment.clear();
    update();
    return false;

  }

  @override
  getComments(String postId) async {
    // TODO: implement getAllPosts
    statusRequest = StatusRequest.loading;
    update();
    var response = await commentsData.getComments(
      currentUserId,
        postId
        );
    statusRequest = handlingData(response);
     print('commeeeeeeeeeeeeeee');
      print(response);
    if (StatusRequest.success == statusRequest) {
      if (response[0]['status'] == "success") {
        List dataResponse = response[0]['data'];
        comments.clear();
        comments.addAll(dataResponse.map((e) => CommentModel.fromJson(e)));
        comment.clear();//clear the comment text controller
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
  // @override
  // getFilteredPosts({required String tag}) async {
  //   // TODO: implement getAllPosts
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await homeScreenData.getPostsByTag(
  //       myServices.sharedPreferences.getString("userID")!,
  //       tag: tag);
  //   statusRequest = handlingData(response);
  //
  //   if (StatusRequest.success == statusRequest) {
  //     if (response[0]['status'] == "success") {
  //       List dataResponse = response[0]['data'];
  //       // Clear the existing list before adding new items
  //       filteredPosts.clear();
  //       filteredPosts.addAll(dataResponse.map((e) => PostModel.fromJson(e)));
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //   print(filteredPosts.length);
  //   update();
  // }
  //
  @override
  deleteComment(String postID,String commentId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await commentsData.deleteComments(
      myServices.sharedPreferences.getString("userID")!,
      postID,
      commentId
    );

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.snackbar(
            "تم حذف التعليق بنجاح",
            '',
            backgroundColor: Colors.grey[500],
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "تم حذف التعليق بنجاح",
              style: TextStyle(fontSize: 16.0.sp),
            ));
        await getComments(postID);//refresh the comments screen
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

}