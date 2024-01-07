import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/alert_exit_app.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/screens/view_article_Screen.dart';
import 'package:pet_connect/view/widgets/articles/article_widget.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/custom_button.dart';
import 'package:pet_connect/view/widgets/home/demo_two_images.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/image_slider.dart';
import 'package:pet_connect/view/widgets/home/posts_list.dart';
import 'package:pet_connect/view/widgets/home/text_and_button_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    ArticlesControllerImp articlesController = Get.put(ArticlesControllerImp());
    MyServices myServices = Get.find();
    String filePath =
        myServices.sharedPreferences.getString('profilePic') ?? '';

    return Scaffold(
        //FAB:
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingActionButton(
            onPressed: controller.showChoosePostTypePopUp),

        //bottomNavigationBar:
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: controller.currentNavIndex,
          onItemTapped: controller.onItemTapped,
          onGalleryTap: () async {
            await controller.getFilteredPosts(tag: 'social');
            controller.goToDynamicScreen(
              '58'.tr,
              posts: controller.filteredPosts,
            );
          },
          onHomeTap: () {
            if (Get.currentRoute == AppRoute.homeScreen) {
              controller.scrollToTop();
            } else {
              Get.offNamed(AppRoute.homeScreen);
            }
          },
          onSettingsTap: () {
            if (Get.currentRoute == AppRoute.homeScreen) {
              Get.toNamed(AppRoute.settingsScreen);
            } else {
              Get.offNamed(AppRoute.settingsScreen);
            }
          },
        ),
        body: WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<HomeControllerImp>(
            builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: SafeArea(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      //The welcome message :
                      Padding(
                        padding: EdgeInsets.only(right: 15.0.w),
                        child: Row(
                          children: [
                            //The Icon:
                            GestureDetector(
                              onTap: controller.goToProfilePage,
                              child: CircleAvatar(
                                backgroundImage: controller
                                            .currentUser.profilePic ==
                                        null
                                    ? null
                                    : NetworkImage(
                                        "${AppLink.linkImageRoot}/$filePath"),
                                radius: 16.h, // Adjust the radius as needed
                                child: controller.currentUser.profilePic == null
                                    ? Icon(
                                        Icons.person,
                                        color: AppColor.primaryColor,
                                        size: 24
                                            .h, // Adjust the icon size as needed
                                      )
                                    : null, // No child for non-null profilePic
                              ),
                            ),

                            SizedBox(
                              width: 8.w,
                            ),
                            //The text:
                            Text(
                              // "مرحبا, ${controller.currentUser.name}!",
                              "مرحبا, ${myServices.sharedPreferences.getString("username")!}!",
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),

                      //All articles line:
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: Row(
                          children: [
                            Text(
                              '58'.tr,
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 22.w,
                            ),
                            CustomButton(
                                onPressed: controller.goToAllArticlesScreen,
                                buttonText: 'جميع المقالات'),
                          ],
                        ),
                      ),

                      //The image slider
                      MyImageSlider(
                        articles: articlesController.articles
                            .map((article) => ArticleWidget(
                                onTap: () {
                                  Get.to(ViewArticlesScreen(
                                      article: articlesController.articles[
                                          controller.currentSliderIndex]));
                                },
                                article: article))
                            .toList(),
                      ),

                      //pets for sale list
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: TextAndButtonRow(
                          text: '59'.tr,
                          onPressed: () async {
                            await controller.getFilteredPosts(tag: 'trading');
                            controller.goToDynamicScreen(
                              '63'.tr,
                              posts: controller.filteredPosts,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      const TwoImagesRow(),
                      SizedBox(
                        height: 7.h,
                      ),

                      //pets for adoption list
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: TextAndButtonRow(
                            text: '60'.tr,
                            onPressed: () async {
                              await controller.getFilteredPosts(
                                  tag: 'adoption');
                              controller.goToDynamicScreen(
                                '60'.tr,
                                posts: controller.filteredPosts,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),

                      const TwoImagesRow(),

                      SizedBox(
                        height: 7.h,
                      ),
                      //pets for mating list
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: TextAndButtonRow(
                            text: '61'.tr,
                            onPressed: () async {
                              await controller.getFilteredPosts(tag: 'mating');
                              controller.goToDynamicScreen(
                                '66'.tr,
                                posts: controller.filteredPosts,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),

                      const TwoImagesRow(),
                      SizedBox(
                        height: 7.h,
                      ),
                      // lost pets  list
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: TextAndButtonRow(
                            text: '62'.tr,
                            onPressed: () async {
                              await controller.getFilteredPosts(tag: 'lost');
                              controller.goToDynamicScreen(
                                '64'.tr,
                                posts: controller.filteredPosts,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),

                      const TwoImagesRow(),
                      SizedBox(
                        height: 7.h,
                      ),

                      //Favorite animals row
                      Padding(
                        padding: EdgeInsets.only(right: 13.0.w),
                        child: Row(
                          children: [
                            Text(
                              "الحيوانات المفضلة اليوم!",
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 75.w,
                            ),
                            //all posts
                            CustomButton(
                                onPressed: () async {
                                  await controller.getAllPosts();
                                  controller.goToDynamicScreen(
                                    '65'.tr,
                                    posts: controller.allPosts,
                                  );
                                },
                                buttonText: 'جميع المنشورات'),
                          ],
                        ),
                      ),

                      //List of posts:
                      controller.allPosts.isNotEmpty
                          ? PostsList(posts: controller.allPosts)
                          : Padding(
                              padding: EdgeInsets.only(top: 30.0.h),
                              child: Center(
                                child: Text(
                                  "لا يوجد منشورات, حاول لاحقا!",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
