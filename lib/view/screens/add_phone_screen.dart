import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/controller/add_phone_controller.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/add_new_pet/custom_text.dart';
import 'package:pet_connect/view/widgets/auth/custom_button_auth.dart';

class AddPhoneScreen extends StatelessWidget {
  const AddPhoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AddPhoneControllerImp());
    MyServices myServices = Get.find();
    String filePath =
        myServices.sharedPreferences.getString('profilePic') ?? '';
    String myPhone = myServices.sharedPreferences.getString("phone") ?? '';
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AddPhoneControllerImp>(
            builder: (controller) => Column(
                  children: [
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
                                backgroundImage: filePath == ''
                                    ? null
                                    : NetworkImage(
                                        "${AppLink.linkImageRoot}/$filePath"),
                                radius: 16.h, // Adjust the radius as needed
                                child: filePath == ''
                                    ? Icon(
                                        Icons.person,
                                        color: AppColor.primaryColor,
                                        size: 24
                                            .h, // Adjust the icon size as needed
                                      )
                                    : null, // No child for non-null profilePic
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: controller.formState,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(numOfText: '50'.tr),
                            TextFormField(
                              //initialValue: 'dljkjdk',
                              cursorColor: AppColor.primaryColor,
                              controller: controller.phone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '51'.tr,
                                errorText: controller.submitted
                                    ? validatePhoneNumber(controller.phone.text)
                                    : null,
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.primaryColor),
                                ),
                              ),
                              enabled: !controller.isEditing,
                              validator: (value) {
                                if (controller.submitted) {
                                  return validatePhoneNumber(value ?? '');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<AddPhoneControllerImp>(
                      builder: (controller) => CustomButtonAuth(
                          text: controller.isEditing ? '169'.tr : '168'.tr,
                          onPressed: () {
                            // print('ISEDI before ---> ${controller.isEditing}');
                            controller.addPhone();
                            //  print('ISEDI after ---> ${controller.isEditing}');
                          }),
                    ),
                  ],
                )),
      ),
    );
  }
}
