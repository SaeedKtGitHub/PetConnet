import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget.dart';

class PetsList extends GetView<CreatePostControllerImp> {
  const PetsList({
    super.key,
    required this.screenName,
    required this.listPetsModel,
  });
  final List<PetModel> listPetsModel;
  final String screenName;
  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    return ListView.builder(
      //primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: listPetsModel.length,
      itemBuilder: (context, index) {
        // return Padding(
        //   padding:  EdgeInsets.only(top: 10.0.h),
        //   child: CustomPetWidget(petIcon: AppImageAsset.dogIcon, onPressed: (){}, onLongPress: (){}),
        // );
        return CustomPetWidget(
            petName: '${listPetsModel[index].name}',
            petImage: '${listPetsModel[index].image}',
            color: controller.selectedIndex == index
                ? AppColor.primaryColor
                : AppColor.black,
            paddingNum: controller.selectedIndex == index ? 3.0 : 0.0,
            onPressed: () {
              controller.openPopUpPetInfo(index: index);
            },
            onLongPress: () {
              if (screenName == "createPost") {
                controller.onLongPressOnItem(index: index);
              }
            });
      },
    );
  }
}
