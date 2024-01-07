import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/profile/profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';

class UserPostsList extends StatefulWidget {
  final List<PostModel> posts;

  const UserPostsList({required this.posts, super.key});

  @override
  State<UserPostsList> createState() => _UserPostsListState();
}

class _UserPostsListState extends State<UserPostsList> {
  final HomeControllerImp homeController = Get.find<HomeControllerImp>(); // Get instance of HomeController
   final ProfileControllerImp controller = Get.find<ProfileControllerImp>();
   final CommentsControllerImp commentsControllerImp = Get.find<CommentsControllerImp>();
  @override

  Widget build(BuildContext context) {
    return ListView.builder(
      // reverse: fa,
      //primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: PostWidget(
            post: widget.posts[index],
            onImageTap: (){
              controller.openPopUpPetInfo(petModel: widget.posts[index].petModel!);
            },
            onDeletePost: () async{
                Get.defaultDialog(
                  titleStyle: const TextStyle(color: AppColor.primaryColor),
                  middleTextStyle:
                  const TextStyle(color: AppColor.black, fontSize: 20),
                  title: 'تنبيه',
                  middleText: 'هل انت متاكد من  حذف هذا المنشور؟',
                  actions: [
                    //no button
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'لا',
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                    //yes button
                    ElevatedButton(
                        onPressed: ()async   {
                          Get.back();
                          bool success = await controller.removePost(widget.posts[index].postID!);
                          controller.userPosts.remove(widget.posts[index]);
                          if (success) {
                            controller.userPosts.remove(widget.posts[index]);
                            //Get.back();
                            setState(() {
                            });
                          }
                        },

                        child: const Text(
                          'نعم',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  ],
                );
              },
            onLikeTap: (){
              homeController.likeOrDislikePost(widget.posts[index].postID!);
            },
            onCommentTap: (){
              commentsControllerImp.setCurrentPostId(widget.posts[index].postID!);
              commentsControllerImp.openCommentsScreen(commentsControllerImp.comments,widget.posts[index].postID!);
              //commentsControllerImp.setCurrentPostId(widget.posts[index].postID!);
              // controller.openCommentsScreen(widget.posts[index].comments!);
            },
            onProfilePicTap: (){
              homeController.goToOtherProfilePage(
                widget.posts[index].userID!,
                widget.posts[index].profilePic!,
                widget.posts[index].username!,);
            },
          ),
        );
      },
    );
  }
}
