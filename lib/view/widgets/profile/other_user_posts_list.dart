import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/profile/other_user_profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';

class OtherUsersPostsList extends StatefulWidget {
  final List<PostModel> posts;

  const OtherUsersPostsList({required this.posts, super.key});

  @override
  State<OtherUsersPostsList> createState() => _OtherUsersPostsListState();
}

class _OtherUsersPostsListState extends State<OtherUsersPostsList> {
  @override
  void initState() {
    super.initState();
    // Check if commentsControllerImp is already initialized
    if (!Get.isRegistered<CommentsControllerImp>()) {
      // Lazy initialize if not already initialized
      Get.lazyPut(() => CommentsControllerImp());
    }
    // Retrieve the instance of CommentsControllerImp
    commentsControllerImp = Get.find<CommentsControllerImp>();
  }
  final HomeControllerImp controller = Get.find<HomeControllerImp>();
  final otherUserProfileController=Get.find<OtherUserProfileControllerImp>();
  late CommentsControllerImp commentsControllerImp ;

  @override

  Widget build(BuildContext context) {
    Get.put(OtherUserProfileControllerImp);
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
                otherUserProfileController.openPopUpPetInfoFromPosts(petModel: widget.posts[index].petModel!, index: index);

              },
              // await  controller.removePost(widget.posts[index].postID!);
              //  controller.allPosts.remove(widget.posts[index]);
              //  setState(() {
              //Get.back();
              //  });
              onDeletePost: () {
                Get.defaultDialog(
                  titleStyle: const TextStyle(color: AppColor.primaryColor),
                  middleTextStyle:
                  const TextStyle(color: AppColor.black, fontSize: 20),
                  title: '101'.tr,
                  middleText: '127'.tr,
                  actions: [
                    //no button
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child:  Text(
                          '104'.tr,
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                    //yes button
                    ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          bool success = await controller.removePost(widget.posts[index].postID!);
                          if (success) {
                            controller.allPosts.remove(widget.posts[index]);
                            //Get.back();
                            setState(() {
                            });
                          }
                        },
                        child:  Text(
                          '103'.tr,
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
                controller.likeOrDislikePost(widget.posts[index].postID!);
              },
              onCommentTap: (){
                commentsControllerImp.setCurrentPostId(widget.posts[index].postID!);
                commentsControllerImp.openCommentsScreen(commentsControllerImp.comments,widget.posts[index].postID!);
                //commentsControllerImp.setCurrentPostId(widget.posts[index].postID!);
                // controller.openCommentsScreen(widget.posts[index].comments!);
              },
              onProfilePicTap: (){
                controller.goToOtherProfilePage(
                  widget.posts[index].userID!,
                  widget.posts[index].profilePic!,
                  widget.posts[index].username!,);
              },
              onContactMeTap:(){
                controller.openContactMeInfo(
                    widget.posts[index].username!,
                    widget.posts[index].userPhone!,
                    widget.posts[index].profilePic!);
              }

          ),
        );
      },
    );
  }
}
