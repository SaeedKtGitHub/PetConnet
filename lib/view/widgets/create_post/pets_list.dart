import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget.dart';

class PetsList extends StatelessWidget {
  const PetsList({
    super.key,
    required this.listOfPetWidget,
  });
  final List<CustomPetWidget> listOfPetWidget;
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    return ListView.builder(
      //primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: listOfPetWidget.length,
      itemBuilder: (context, index) {
        // return Padding(
        //   padding:  EdgeInsets.only(top: 10.0.h),
        //   child: CustomPetWidget(petIcon: AppImageAsset.dogIcon, onPressed: (){}, onLongPress: (){}),
        // );
        return GetBuilder<CreatePostControllerImp>(
            builder: (controller) => CustomPetWidget(
                petName: listOfPetWidget[index].petName,
                petImage: listOfPetWidget[index].petImage,
                petIcon: listOfPetWidget[index].petIcon,
                index: index,
                onPressed: () {},
                onLongPress: () {
                  controller.onLongPressOnItem(index: index);
                }));
      },
    );
  }
}
