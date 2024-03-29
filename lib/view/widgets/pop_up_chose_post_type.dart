import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/screens/web_view_screen.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/new_social_post_container.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/tag_items_list.dart';

class ChoosePostTypePopUp extends StatelessWidget {
  const ChoosePostTypePopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get.put(CreatePostControllerImp());
    Get.find<HomeControllerImp>();
    return Container(
      height: 370.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: GetBuilder<HomeControllerImp>(
        builder: (controller) => Column(
          children: [
            //choose post type:
            Row(
              children: [
                //The cancel button
                GestureDetector(
                  onTap: controller.backToHome,
                  child: Image.asset(
                    AppImageAsset.cancel,
                    width: 43.0.w,
                    height: 43.0.h,
                  ),
                ),
                SizedBox(width: 50.w),
                //The title:
                Text(
                  '143'.tr,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const NewSocialPostContainer(),
            SizedBox(
              height: 8.h,
            ),
            //Pets text
            Padding(
              padding: EdgeInsets.only(right: 10.0.w,left: 10.w),
              child: Row(
                children: [
                  Text(
                    '144'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //List tags items for traffic users:
            TagItemList(tagItems: trafficTagsItems),
            //Services and products text

            //   //List tags items for other  users (shops,vets,writers):
            //   TagItemList(tagItems: businessTagsItems),
            // //some information text to inform vets,shops,writers to
            //   // register as their type to ofer products and services :
            // Padding(
            //   padding: EdgeInsets.all(10.0.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         textAlign: TextAlign.center,
            //         'يجب التسجيل كمتجر أو طبيب بيطري أولاً للحصول على صلاحية\nعرض منتجات وخدمات.',
            //         style: TextStyle(
            //             fontSize: 9.sp,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.grey[700]),
            //       ),
            //     ],
            //   ),
            // ),
            //go to login to register as a vet or shop or writer
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       textAlign: TextAlign.center,
            //       'الرجاء التوجه لصفحة المستخدم للتسجيل.',
            //       style: TextStyle(
            //           fontSize: 10,
            //           fontWeight: FontWeight.bold,
            //           color: AppColor.primaryColor),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(1.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '47'.tr,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        //TODO: Web view
                        onTap: () {
                          Get.to(
                            WebViewScreen(
                              pageLink: AppLink.privacyPolicy,
                            ),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          '48'.tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.primaryColor,
                              color: AppColor.primaryColor),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        //and
                        '55'.tr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      InkWell(
                        //TODO: Web view
                        onTap: () {
                          Get.to(
                            WebViewScreen(
                              pageLink: AppLink.termsCondition,
                            ),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          '56'.tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.primaryColor,
                              color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
