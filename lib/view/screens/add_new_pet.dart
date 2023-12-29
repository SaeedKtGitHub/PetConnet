import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/add_new_pet_controller.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:pet_connect/view/widgets/add_new_pet/build_toggle_button_with_gender_icon.dart';
import 'package:pet_connect/view/widgets/add_new_pet/custom_text.dart';
import 'package:pet_connect/view/widgets/add_new_pet/date_picker.dart';
import 'package:pet_connect/view/widgets/add_new_pet/gender_toggles.dart';
import 'package:pet_connect/view/widgets/add_new_pet/pet_toggle.dart';
import 'package:pet_connect/view/widgets/add_new_pet/pets_types_toggles.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';
import 'package:pet_connect/view/widgets/auth/custom_text_form.dart';
import 'package:pet_connect/view/widgets/create_post/custom_choose_image_button.dart';
import 'package:pet_connect/view/widgets/create_post/custom_show_image.dart';
import 'package:pet_connect/view/widgets/create_post/custom_text_body.dart';
import 'package:pet_connect/view/widgets/custom_title_with_icon.dart';

class AddNewPet extends StatefulWidget {
  const AddNewPet({Key? key}) : super(key: key);

  @override
  State<AddNewPet> createState() => _AddNewPetState();
}

class _AddNewPetState extends State<AddNewPet> {

  @override
  Widget build(BuildContext context) {
    AddNewPetControllerImp controller=  Get.put(AddNewPetControllerImp());
    return Scaffold(
      body: GetBuilder<AddNewPetControllerImp>(
        builder: (controller)=> SafeArea(

            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    //First text(add new pet,and back icon)
                    CustomTitleWithIcon(
                      numOfText: '29',
                      imagePath: AppImageAsset.backIcon,
                      onPressed: () {
                        ///Call function to go back to home screen (from controller).
                        controller.back();
                      },
                    ),
                    SizedBox(height: 10.h,),
                    const CustomText(numOfText: '28'),
                   // SizedBox(height: 10.h,),
                    //Choose pet image container (from camera or gallery)
                    controller.isShowImage
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
                    SizedBox(height: 15.h,),

                    //asking about the animal type (text and buttons)
                    Padding(
                      padding:  EdgeInsets.only(right: 75.0.w,left: 75.w),
                      child: CustomText(numOfText: '30'),
                    ),
                    SizedBox(height: 8.h,),
                    PetsTypesToggleButtons(
                      isSelected: controller.isSelectedPetType,
                      onPressed: (int index) {
                        controller.onPetTypeTogglePress(index);
                      },
                    ),
                    SizedBox(height: 20.h,),
                    //Gender text :
                    Row(
                      children: [
                        CustomText(numOfText: '35'),
                        Spacer(),
                        Padding(
                          padding:EdgeInsets.only(left: 40.0.w),
                           child:
                           GenderToggleButtons(
                             isSelected: controller.isSelectedPetGender,
                             onPressed: (int index) {
                               controller.onPetGenderTogglePress(index);
                               print(controller.selectedGender);
                             },
                           ),
                        ),

                      ],
                    ),
                    SizedBox(height: 14.h,),
                    //Birth date row
                    Row(
                      children: [
                        //Birth date text
                        CustomText(numOfText: '38'),
                        Spacer(),
                        //Birth date button picker
                        Padding(
                          padding:  EdgeInsets.only(left: 40.w),
                          child: DatePickerButton(
                              onPressed:(){
                                controller.presentDatePicker(context);
                              },
                              text: controller.getSelectedDate()!)
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h,),
                    //breed :
                    CustomText(numOfText: '40'),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      //height: 100.h, // Adjust the height as needed
                      child: Form(
                        key: controller.formState,
                        child: Column(
                          children: [
                            CustomTextForm(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 3, 50, 'text');
                              },
                              myController: controller.breed,
                              hintText: '41'.tr,
                            ),
                           // pet favorite name :
                            //SizedBox(height: 7.h,),
                            CustomText(numOfText: '42'),
                            SizedBox(height: 5.h,),
                            CustomTextForm(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 2, 50, 'text');
                              },
                              myController: controller.favName,
                              hintText: '43'.tr,
                            ),
                            CustomButtonAuth(
                                text: '44'.tr,
                                onPressed: () {
                                      controller.addPet();
                                }),
                          ],
                        ),


                      ),
                    ),

                  ],
                ),
              ),
            ),

        ),
      ),
    );

  }

}
