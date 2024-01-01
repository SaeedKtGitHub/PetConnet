import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/custom_button.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/image_slider.dart';
import 'package:pet_connect/view/widgets/home/posts_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());

    return Scaffold(
        //FAB:
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingActionButton(
            onPressed: controller.showChoosePostTypePopUp),

        //bottomNavigationBar:
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: controller.currentNavIndex,
          onItemTapped: controller.onItemTapped,
        ),
        body: GetBuilder<HomeControllerImp>(
          builder: (controller) => SafeArea(
            child: SingleChildScrollView(
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
                        CircleAvatar(
                          backgroundImage: controller.currentUser.profilePic ==
                                  null
                              ? null
                              : NetworkImage(
                                  "${AppLink.linkImageRoot}/${controller.currentUser.profilePic}"),
                          radius: 16.h, // Adjust the radius as needed
                          child: controller.currentUser.profilePic == null
                              ? Icon(
                                  Icons.person,
                                  color: AppColor.primaryColor,
                                  size: 24.h, // Adjust the icon size as needed
                                )
                              : null, // No child for non-null profilePic
                        ),

                        SizedBox(
                          width: 8.w,
                        ),
                        //The text:
                        Text(
                          "مرحبا, ${controller.currentUser.name}!",
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
                          "آخر مقالات وأخبار الحيوانات الأليفة!",
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
                            onPressed: () {}, buttonText: 'جميع المقالات'),
                      ],
                    ),
                  ),

                  //The image slider
                  MyImageSlider(
                      articles: controller.slider_articles_widgets(slides)),

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
                        CustomButton(
                            onPressed: () {}, buttonText: 'جميع المنشورات'),
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
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
