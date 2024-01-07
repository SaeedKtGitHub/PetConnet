import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/profile/OtherUserProfileImage.dart';
import 'package:pet_connect/controller/profile/other_user_profile_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/widgets/home/posts_list.dart';
import 'package:pet_connect/view/widgets/profile/other_user_pets_list.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({Key? key,
    required this.userId,
    required this.userProfilePath,
    required this.username,
  }) : super(key: key);
  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
  final String  userId;
  final String  userProfilePath;
  final String  username;

}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    Get.put(OtherUserProfileControllerImp(widget.userId));
   // HomeControllerImp homeController = Get.find<HomeControllerImp>();
    HomeControllerImp homeController = Get.find<HomeControllerImp>();

    // Get.lazyPut(()=>HomeControllerImp());
    MyServices myServices = Get.find();
    return Scaffold(
      body: WillPopScope(
        onWillPop: backToHomeScreen,
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<OtherUserProfileControllerImp>(
              builder: (controller) =>
                  HandlingDataRequest(
                    statusRequest: controller.statusRequest,
                    widget: Column(
                      children: [
                    SizedBox(height: 12.h),
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
                        OtherUserProfileImage(imagePath: widget.userProfilePath),//will not show camera icon
                    SizedBox(height: 10.h),
                    //The username:
                    Center(
                      child: Text(
                        // myServices.sharedPreferences.getString("username")!,
                        widget.username,
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                    ),
                    // //The user location:
                    // Center(
                    //   child: Text(
                    //     'عمان_الأردن',
                    //     style: TextStyle(
                    //         color: AppColor.black,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16.sp),
                    //   ),
                    // ),
                    //Email Row
                    // UserDataRow(
                    //   icon: const Icon(
                    //     Icons.email,
                    //     color: AppColor.primaryColor,
                    //   ),
                    //   text: 'myServices.sharedPreferences.getString("email")!',
                    // ),
                    //Phone Row
                    SizedBox(height: 20.h),
                    //The pets list:
                        controller.userPetsListProfile.isNotEmpty ?
                          SizedBox(
                      height: 140.h, // Adjust the height as needed
                      child: Row(
                        children: [
                          //TODO: Make this list dynamic.
                          OtherUserPetsList(
                            listPetsModel: controller.userPetsListProfile,
                          ),
                          //  SizedBox(height: 15.h,),
                        ],
                      ),
                    )
                        :
                            Padding(
                              padding:  EdgeInsets.only(bottom: 25.0.h),
                              child: Center(child: Center(child: Text(
                                'لا يوجد حيوانات أليفة'
                              ,style:TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16.sp
                              )
                                ,),),),
                            )
                        ,

                        if(controller.userPosts.isNotEmpty)
                        Text('90'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23.sp,
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    //List of posts:
                    controller.userPosts.isNotEmpty
                        ? PostsList(posts: controller.userPosts)
                        :Container()
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
