import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';


class DynamicViewScreen extends StatelessWidget {
  final String title;
  final List<PostModel> posts;

  const DynamicViewScreen({super.key, required this.title, required this.posts});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return Scaffold(

      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(onPressed: controller.showChoosePostTypePopUp),

      //bottomNavigationBar
      bottomNavigationBar:  CustomBottomNavigationBar(
        currentIndex: controller.currentNavIndex,
        onItemTapped: controller.onItemTapped,
        onGalleryTap:()async {
          await  controller.getFilteredPosts(tag: 'social');
          controller.goToDynamicScreen('58'.tr, posts:controller.filteredPosts,
          );
        },
        onHomeTap: () {
          if (Get.currentRoute ==AppRoute.homeScreen) {
            controller.scrollToTop();
          } else {
            Get.offNamed(AppRoute.homeScreen);
          }
        },
        onSettingsTap: (){
          if (Get.currentRoute ==AppRoute.homeScreen) {
            Get.toNamed(AppRoute.settingsScreen);
          }else{
            Get.offNamed(AppRoute.settingsScreen);

          }

        },
      ),
      body : SafeArea(
        child:posts.isNotEmpty ?  GetBuilder<HomeControllerImp>(
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
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ),

                            SizedBox(
                              width: 12.w,
                            ),
                            //The title (depending on filter (tag)):
                            Text(
                              title,
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 19.sp,
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
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: PostWidget(
                                post: posts[index],
                                onImageTap:(){
                                  controller.openPopUpPetInfo(petModel: posts[index].petModel!, index: index);
                                }
                                ,
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
