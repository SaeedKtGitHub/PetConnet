import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/show_dialog.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/tag_item.dart';

class TagItemList extends StatelessWidget {
  final List<TagItem> tagItems;

  const TagItemList({super.key, required this.tagItems});

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    CreatePostControllerImp createController =
        Get.find<CreatePostControllerImp>();
    MyServices myServices = Get.find();
    String hasPhone = myServices.sharedPreferences.getString("phone") ?? '';

    return Container(
      margin: EdgeInsets.all(5.h), // Set margin for the entire list
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse:
          Get.locale!.languageCode=='ar' ? true:false, 
          itemCount: tagItems.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: TagItem(
                onPressed: () {
                  Get.back();
                  if (hasPhone.isNotEmpty) {
                    createController.getTagFromPopUp(index: index);
                    Get.back();
                    Get.toNamed(AppRoute.createPostScreen);
                    print('INDEX ----> $index');
                  } else {
                    showDefDialog(
                        title: '101'.tr,
                        message:
                            '142'.tr,
                        onNoPressed: () {
                          Get.back();
                        },
                        onYesPressed: () {
                          Get.back();
                          Get.toNamed(AppRoute.settingsScreen);
                        });
                  }
                },
                iconPath: tagItems[index].iconPath,
                text: tagItems[index].text,
              ),
            );
          },
        ),
      ),
    );
  }
}
