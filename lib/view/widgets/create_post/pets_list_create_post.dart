import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget_create.dart';

class PetsListCreatePost extends GetView<CreatePostControllerImp> {
  const PetsListCreatePost({
    Key? key,
    required this.listPetsModel,
  }) : super(key: key);

  final List<PetModel> listPetsModel;

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listPetsModel.length,
        itemBuilder: (context, index) {
          return GetBuilder<CreatePostControllerImp>(
            init: CreatePostControllerImp(), // Add this line
            builder: (controller) => CustomPetWidgetCreate(
              petName: '${listPetsModel[index].name}',
              petImage: '${listPetsModel[index].image}',
              color: controller.selectedIndex == index
                  ? AppColor.primaryColor
                  : AppColor.black,
              paddingNum: controller.selectedIndex == index ? 3.0 : 0.0,
              onPressed: () {
                controller.selectedIndex = index;
                controller.openPopUpPetInfo(petModel: listPetsModel[index]);
              },
              onLongPress: () {
                controller.onLongPressOnItem(index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
