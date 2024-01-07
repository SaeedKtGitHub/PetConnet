import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';


class DynamicViewScreen extends StatefulWidget {
  final String title;
  final List<PostModel> posts;

  const DynamicViewScreen({super.key, required this.title, required this.posts});

  @override
  State<DynamicViewScreen> createState() => _DynamicViewScreenState();
}

class _DynamicViewScreenState extends State<DynamicViewScreen> {
  late CommentsControllerImp commentsControllerImp;

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
  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeController = Get.find<HomeControllerImp>();

    return Scaffold(

      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(onPressed: homeController.showChoosePostTypePopUp),

      //bottomNavigationBar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: homeController.currentNavIndex,
        onItemTapped: homeController.onItemTapped,
        onGalleryTap:()async {
          await  homeController.getFilteredPosts(tag: 'social');
          homeController.goToDynamicScreen('65'.tr, posts:homeController.filteredPosts,
          );
        },
        onHomeTap:homeController.scrollToTopOrGoHome,
        onSettingsTap:homeController.goToSettingsScreen,
        onProfieTap:  homeController.goToProfilePage,
      ),
      body : SafeArea(
        child:widget.posts.isNotEmpty ?  GetBuilder<HomeControllerImp>(
            builder: (controller)=>
                HandlingDataRequest(
                 statusRequest: controller.statusRequest,
                  widget: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      //  First row with an icon and title
                      Padding(
                        padding: EdgeInsets.only(right: 15.0.w),
                        child: Row(
                          children: [
                            //back Icon
                            InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Image.asset(
                                  AppImageAsset.backIcon,
                                  height: 22.h,
                                  width: 22.w,
                                ),
                              ),

                            SizedBox(
                              width: 12.w,
                            ),
                            //The title (depending on filter (tag)):
                            Text(
                              widget.title,
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            //The image(if exists) or Icon :
                            Padding(
                              padding:  EdgeInsets.only(left: 12.0.w),
                              child: CircleAvatar(
                                backgroundImage: controller.currentUser.profilePic == null
                                    ? null
                                    : NetworkImage("${AppLink.linkImageRoot}/${controller.currentUser.profilePic}"),
                                radius: 16.h, // Adjust the radius as needed
                                child: controller.currentUser.profilePic == null
                                    ? Icon(
                                  Icons.person,
                                  color: AppColor.primaryColor,
                                  size: 24.h, // Adjust the icon size as needed
                                )
                                    : null,  // No child for non-null profilePic
                              ),
                            ),

                          ],
                        ),
                      ),
                      // Your list of posts
                        Expanded(

                            child: ListView.builder(
                            //shrinkWrap: true,
                           // physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.posts.length,
                            itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: PostWidget(
                                post: widget.posts[index],
                                onImageTap:(){
                                  controller.openPopUpPetInfo(petModel: widget.posts[index].petModel!, index: index);
                                },
                                onDeletePost: ()async   {
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
                                          onPressed: () async  {
                                            Get.back();

                                            bool success = await controller.removePost(widget.posts[index].postID!);
                                            controller.filteredPosts.remove(widget.posts[index]);
                                            if (success) {
                                              controller.filteredPosts.remove(widget.posts[index]);
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
                                }
                              ),
                        );
                      },
                    ),
                  ),
                                ],
                              ),
                ),
          ):
          const Center(
            child: Text('لا يوجد منشورات بعد,حاول لاحقا'),
          )
      ),

    );
  }
}
