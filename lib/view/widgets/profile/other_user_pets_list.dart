import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile/profile_controller.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/profile/custom_pet_widget_profile.dart';

class OtherUserPetsList extends GetView<ProfileControllerImp> {
  const OtherUserPetsList({
    Key? key,
    required this.listPetsModel,
  }) : super(key: key);

  final List<PetModel> listPetsModel;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileControllerImp());
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listPetsModel.length,
        itemBuilder: (context, index) {
          return GetBuilder<ProfileControllerImp>(
            init: ProfileControllerImp(), // Add this line
            builder: (controller) => CustomPetWidgetProfile(
              petName: '${listPetsModel[index].name}',
              petImage: '${listPetsModel[index].image}',
              onPressed: () {
                controller.selectedIndex = index;
                controller.openPopUpPetInfo(petModel: listPetsModel[index]);
              },

            ),
          );
        },
      ),
    );
  }
}
