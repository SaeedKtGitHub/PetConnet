import 'package:flutter/material.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:get/get.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';

class DynamicPostsList extends StatefulWidget {
  const DynamicPostsList({Key? key,required this.posts}) : super(key: key);
  final List<PostModel> posts;
  @override
  State<DynamicPostsList> createState() => _DynamicPostsListState();
}

class _DynamicPostsListState extends State<DynamicPostsList> {
  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeController = Get.find<HomeControllerImp>();
    CommentsControllerImp commentsControllerImp = Get.find<CommentsControllerImp>();

    return Expanded(

      child: ListView.builder(
        //shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount:widget.posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: PostWidget(
                post: widget.posts[index],
                onImageTap:(){
                  homeController.openPopUpPetInfo(petModel:widget.posts[index].petModel!, index: index);
                },
                onDeletePost: ()async   {
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
                          onPressed: () async  {
                            Get.back();

                            bool success = await homeController.removePost(widget.posts[index].postID!);
                            homeController.filteredPosts.remove(widget.posts[index]);
                            if (success) {
                              homeController.filteredPosts.remove(widget.posts[index]);
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
                onContactMeTap:(){
                  homeController.openContactMeInfo(
                      widget.posts[index].username!,
                      widget.posts[index].userPhone!,
                      widget.posts[index].profilePic!);
                }
            ),

          );
        },
      ),
    )
      ;
  }
}

