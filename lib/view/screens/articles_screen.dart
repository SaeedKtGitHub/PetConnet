import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/home_controller.dart';
// import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/articles/articles_list.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
// import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
// import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
// import 'package:pet_connect/view/widgets/home/post_widget.dart';


class ArticlesScreen extends StatelessWidget {

  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeController = Get.find<HomeControllerImp>();
    ArticlesControllerImp articlesController = Get.put(ArticlesControllerImp());
    return Scaffold(

      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(onPressed: homeController.showChoosePostTypePopUp),

      //bottomNavigationBar
      bottomNavigationBar:  CustomBottomNavigationBar(
        currentIndex: homeController.currentNavIndex,
        onItemTapped: homeController.onItemTapped,
        onGalleryTap:()async {
          await  homeController.getFilteredPosts(tag: 'social');
          homeController.goToDynamicScreen('65'.tr, posts:homeController.filteredPosts,
          );
        },
        onHomeTap: () {
          if (Get.currentRoute ==AppRoute.homeScreen) {
            homeController.scrollToTop();
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
        onProfieTap:  homeController.goToProfilePage,
      ),
      body : SafeArea(
        child: GetBuilder<HomeControllerImp>(
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
                            'آخر المقالات والأخبار',
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


                    //Your list of articles

                     ArticlesList(
                          articles: articlesController.articles),

                  ],
                ),
              ),
        ),
      ),

    );
  }

}
