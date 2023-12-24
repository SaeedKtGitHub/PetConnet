import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/create_post/custom_add_pet_button.dart';
import 'package:pet_connect/view/widgets/create_post/custom_choose_image_button.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget.dart';
import 'package:pet_connect/view/widgets/create_post/custom_show_image.dart';
import 'package:pet_connect/view/widgets/create_post/custom_text_body.dart';
import 'package:pet_connect/view/widgets/create_post/pets_list.dart';
import 'package:pet_connect/view/widgets/custom_title_with_icon.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColorWhite,
      body: GetBuilder<CreatePostControllerImp>(
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
                    height: 160.h, // Adjust the height as needed
                    child: Row(
                      children: [
                        CustomAddPetButton(
                          onPressed: () {
                            // TODO: Call function to allow the user to choose a pet.
                            // TODO: Go to the Add Pet screen.
                          },
                        ),
                        SizedBox(width: 10.w),
                        //TODO: Make this list dynamic.
                        Expanded(
                          // child: PetsList(
                          //   listOfPetWidget: testPetList,
                          // ),
                          // child: ListView.builder(
                          //   //primary: false,
                          //   shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: controller.dataList.length,
                          //   itemBuilder: (context, index) {
                          //     // return Padding(
                          //     //   padding:  EdgeInsets.only(top: 10.0.h),
                          //     //   child: CustomPetWidget(petIcon: AppImageAsset.dogIcon, onPressed: (){}, onLongPress: (){}),
                          //     // );
                          //     return GetBuilder<CreatePostControllerImp>(
                          //         builder: (controller) => CustomPetWidget(
                          //             petName:
                          //                 '${controller.dataList[index].name}',
                          //             petImage:
                          //                 '${controller.dataList[index].image}',
                          //             onPressed: () {},
                          //             onLongPress: () {
                          //               controller.onLongPressOnItem(
                          //                   index: index);
                          //             }));
                          //   },
                          // ),
                          child:
                              PetsList(listPetsModel: controller.userPetsList),
                          //test PetsList(listPetsModel: testPetList),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100, // Adjust the height as needed
                    child: Form(
                      key: controller.formState,
                      child: CustomTextForm(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 3, 50, 'text');
                        },
                        myController: controller.content,
                        hintText: '20'.tr,
                        labelText: '21'.tr,
                        iconData: Icons.text_fields,
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
    );
  }
}
