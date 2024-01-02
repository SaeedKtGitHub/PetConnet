import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/widgets/create_post/custom_add_pet_button.dart';
import 'package:pet_connect/view/widgets/profile/data_row.dart';
import 'package:pet_connect/view/widgets/profile/image_profile.dart';
import 'package:pet_connect/view/widgets/profile/pets_list_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileControllerImp());
    MyServices myServices = Get.find();
    return Scaffold(
      body: WillPopScope(
        onWillPop: backToHomeScreen,
        child: SafeArea(
          child: GetBuilder<ProfileControllerImp>(
            builder: (controller) => Column(
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
                //The profil image
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
                  height: 160.h, // Adjust the height as needed
                  child: Row(
                    children: [
                      CustomAddPetButton(
                        onPressed: () {
                          controller.goToAddPetScreen();
                        },
                      ),
                      SizedBox(width: 10.w),
                      //TODO: Make this list dynamic.
                      Expanded(
                        child: PetsListProfile(
                          listPetsModel: controller.userPetsListProfile,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
