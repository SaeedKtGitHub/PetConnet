import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/profile/profile_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/widgets/create_post/custom_add_pet_button.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/profile/data_row.dart';
import 'package:pet_connect/view/widgets/profile/image_profile.dart';
import 'package:pet_connect/view/widgets/profile/pets_list_profile.dart';
import 'package:pet_connect/view/widgets/profile/user_posts_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileControllerImp());
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    MyServices myServices = Get.find();
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
              tag:"social"

          );
          homeController.resetSearchRefresh();
        },
        onHomeTap:homeController.scrollToTopOrGoHome,
        onSettingsTap:homeController.goToSettingsScreen,
        onProfieTap:  homeController.goToProfilePage,
      ),      body: WillPopScope(
        onWillPop: backToHomeScreen,
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<ProfileControllerImp>(
              builder: (controller) =>
                  HandlingDataRequest(
                    statusRequest: controller.statusRequest,
                    widget: Column(
                                    children: [
                    SizedBox(height: 10.h),
                    // Back button :
                    Row(
                      children: [
                        SizedBox(
                          width: 12.w,
                        ),

                        //The back button
                        InkWell(
                          onTap: controller.backToHomeScreen,
                          child: Image.asset(
                            AppImageAsset.backIcon,
                            height: 35.h,
                            width: 35.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    //The profile image
                    ProfileImage(onPressed: controller.getImageSourceOption),
                    SizedBox(height: 10.h),
                    //The username:
                    Center(
                      child: Text(
                        myServices.sharedPreferences.getString("username")!,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                    ),
                    //The user location:
                    Center(
                      child: Text(
                        'عمان_الأردن',
                        style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                    ),
                    //Email Row
                    UserDataRow(
                      icon: const Icon(
                        Icons.email,
                        color: AppColor.primaryColor,
                      ),
                      text: myServices.sharedPreferences.getString("email")!,
                    ),
                    //Phone Row
                    SizedBox(height: 20.h),
                    //The pets list:
                    SizedBox(
                      height: 140.h, // Adjust the height as needed
                      child: Row(
                        children: [
                          CustomAddPetButton(
                            onPressed: () {
                              controller.goToAddPetScreen();
                            },
                          ),
                          SizedBox(width: 10.w),
                          //TODO: Make this list dynamic.
                          PetsListProfile(
                            listPetsModel: controller.userPetsListProfile,
                          ),
                        //  SizedBox(height: 15.h,),
                        ],
                      ),
                    ),

                    Text('90'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23.sp,
                      ),
                    ),
                                    //  SizedBox(height: 10.h,),

                    //List of posts:
                    controller.userPosts.isNotEmpty
                        ? UserPostsList(posts: controller.userPosts)
                        : Padding(
                          padding: EdgeInsets.only(top: 17.0.h,left: 13.w,right: 13.w),
                          child: Center(
                            child: Text(
                              "لا توجد منشورات حاليًا، ابدأ بإضافة منشوراتك لتحسين تجربتك!",
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
      ),
    );
  }
}
