import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/settings_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/link_api.dart';
import 'package:get/get.dart';
import 'package:pet_connect/view/screens/web_view_screen.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/settings/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    MyServices myServices = Get.find();
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    SettingsControllerImp settingsControllerImp =
        Get.put(SettingsControllerImp());
    String filePath =
        myServices.sharedPreferences.getString('profilePic') ?? '';

    return Scaffold(
      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(
          onPressed: homeController.showChoosePostTypePopUp),

      //bottomNavigationBar
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            //First row:profile pic and back button
            Padding(
              padding: EdgeInsets.only(right: 15.0.w, left: 12.w),
              child: Row(
                children: [
                  //back Icon:
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImageAsset.backIcon,
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                  Spacer(),
                  //username and profile
                  Row(
                    children: [
                      //username
                      Text(
                        " ${myServices.sharedPreferences.getString("username")}",
                        //textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      //user profile :
                      CircleAvatar(
                        backgroundImage:
                            controller.currentUser.profilePic == null
                                ? null
                                : NetworkImage(
                                    "${AppLink.linkImageRoot}/$filePath"),
                        radius: 16.h, // Adjust the radius as needed
                        child: controller.currentUser.profilePic == null
                            ? Icon(
                                Icons.person,
                                color: AppColor.primaryColor,
                                size: 24.h, // Adjust the icon size as needed
                              )
                            : null, // No child for non-null profilePic
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            ////////personal data///////////
            Padding(
              padding: EdgeInsets.only(right: 22.0.w),
              child: Row(
                children: [
                  Text(
                    'معلوماتي الشخصية',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            //change user image
            SettingTile(
                text: 'الصورة الشخصية',
                onPressed: () {
                  settingsControllerImp.goToProfilePage();
                }),
            SizedBox(
              height: 5.h,
            ),
            SettingTile(
                text: 'رقم الهاتف',
                onPressed: () {
                  settingsControllerImp.goToAddPhoneNumberScreen();
                }),

            SizedBox(
              height: 8.h,
            ),
            //First row:profile pic and back button
            SizedBox(
              height: 25.h,
            ),
            //////////account data/////////
            Padding(
              padding: EdgeInsets.only(right: 22.0.w),
              child: Row(
                children: [
                  Text(
                    'الحساب',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            //logout
            SettingTile(
                text: 'تسجيل الخروج من الحساب',
                onPressed: () {
                  settingsControllerImp.logout();
                }),
            SizedBox(
              height: 5.h,
            ),
            //delete account
            SettingTile(
                text: 'حذف الحساب',
                onPressed: () {
                  settingsControllerImp.deleteAccount();
                }),
            SizedBox(
              height: 5.h,
            ),
            SettingTile(
                text: 'حذف رقم الهاتف',
                onPressed: () {
                  settingsControllerImp.deletePhone();
                }),

            SizedBox(
              height: 25.h,
            ),
            //conditions and policies
            Padding(
              padding: EdgeInsets.only(right: 22.0.w),
              child: Row(
                children: [
                  Text(
                    'السياسات والشروط',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            ////////////terms and conditions//////
            SettingTile(
                text: 'الشروط والأحكام',
                onPressed: () {
                  Get.to(
                    WebViewScreen(
                      pageLink: AppLink.termsCondition,
                    ),
                  );
                }),
            SizedBox(
              height: 5.h,
            ),
            //privacy policy
            SettingTile(
                text: 'سياسة الخصوصية',
                onPressed: () {
                  Get.to(
                    WebViewScreen(
                      pageLink: AppLink.privacyPolicy,
                    ),
                  );
                }),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      )),
    );
  }
}
