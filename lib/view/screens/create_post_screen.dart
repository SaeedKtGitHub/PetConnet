import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:pet_connect/view/widgets/add_new_pet/custom_text.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/create_post/custom_add_pet_button.dart';
import 'package:pet_connect/view/widgets/create_post/custom_choose_image_button.dart';
import 'package:pet_connect/view/widgets/create_post/custom_show_image.dart';
import 'package:pet_connect/view/widgets/create_post/custom_text_body.dart';
import 'package:pet_connect/view/widgets/create_post/pets_list_create_post.dart';
import 'package:pet_connect/view/widgets/custom_title_with_icon.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColorWhite,
      body: WillPopScope(
        onWillPop: backToHomeScreen,
        child: GetBuilder<CreatePostControllerImp>(
          builder: (controller) => SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(11.w, 0, 11.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleWithIcon(
                      numOfText: '13',
                      imagePath: AppImageAsset.backIcon,
                      onPressed: () {
                        ///Call function to go back to home screen (from controller).
                        controller.backToHomeScreen();
                      },
                    ),
                    const CustomTextBody(numOfText: '14'),
                    // TODO: Call function to replace this row
                    // TODO: with image that took from user (from controller).
                    GetBuilder<CreatePostControllerImp>(
                      builder: (controller) => controller.isShowImage
                          ? CustomShowImage(
                              imageFile: controller.myFile!,
                              onPressed: () {
                                controller.removeImage();
                              })
                          : Row(
                              children: [
                                CustomChooseImageButton(
                                  numOfText: '15',
                                  iconData: Icons.camera_alt,
                                  onPressed: () {
                                    ///Call function to open camera (from controller).
                                    controller.chooseImageFromCamera();
                                  },
                                ),
                                SizedBox(width: 16.w),
                                CustomChooseImageButton(
                                  numOfText: '16',
                                  iconData: Icons.photo_library_outlined,
                                  onPressed: () {
                                    ///Call function to open gallery (from controller).
                                    controller.chooseImageFromGallery();
                                  },
                                ),
                              ],
                            ),
                    ),

                    const CustomTextBody(numOfText: '17'),
                    Text(
                      '18'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 125.h, // Adjust the height as needed
                      child: Row(
                        children: [
                          CustomAddPetButton(
                            onPressed: () {
                              // TODO: Call function to allow the user to choose a pet.
                              // TODO: Go to the Add Pet screen.
                              controller.goToAddPetScreen();
                            },
                          ),
                          SizedBox(width: 10.w),
                          //TODO: Make this list dynamic.
                          Expanded(
                            child: PetsListCreatePost(
                              listPetsModel: controller.userPetsListCreate,
                            ),
                            //test PetsList(listPetsModel: testPetList),
                          ),
                        ],
                      ),
                    ),

                    ///TRADING
                    controller.myTag == "trading"
                        ? SizedBox(
                            //height: 100.h, // Adjust the height as needed
                            child: Form(
                              key: controller.formState,
                              child: Column(
                                children: [
                                  const CustomText(numOfText: '21'),
                                  CustomTextForm(
                                    isNumber: false,
                                    valid: (val) {
                                      return validInput(val!, 3, 500, 'text');
                                    },
                                    iconData: Icons.text_fields_outlined,
                                    myController: controller.content,
                                    hintText: '20'.tr,
                                  ),
                                  const CustomText(numOfText: '52'),
                                  CustomTextForm(
                                    suffixText: '54'.tr,
                                    isNumber: true,
                                    valid: (val) {
                                      return validInput(val!, 1, 10, 'text');
                                    },
                                    iconData: Icons.attach_money_outlined,
                                    myController: controller.price,
                                    hintText: '53'.tr,
                                  ),
                                ],
                              ),
                            ),
                          )

                        ///Any thing lost, adoption...
                        : SizedBox(
                            //height: 100.h, // Adjust the height as needed
                            child: Form(
                              key: controller.formState,
                              child: Column(
                                children: [
                                  const CustomText(numOfText: '21'),
                                  CustomTextForm(
                                    isNumber: false,
                                    valid: (val) {
                                      return validInput(val!, 3, 500, 'text');
                                    },
                                    iconData: Icons.text_fields_outlined,
                                    myController: controller.content,
                                    hintText: '20'.tr,
                                  ),
                                ],
                              ),
                            ),
                          ),

                    Center(
                      child: CustomButtonAuth(
                          text: '22'.tr,
                          onPressed: () {
                            controller.addPost();
                          }),
                    )
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
