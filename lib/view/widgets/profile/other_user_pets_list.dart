import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile/other_user_profile_controller.dart';
import 'package:pet_connect/controller/profile/profile_controller.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/profile/custom_pet_widget_profile.dart';

class OtherUserPetsList extends GetView<OtherUserProfileControllerImp> {
  const OtherUserPetsList({
    Key? key,
    required this.listPetsModel,
  }) : super(key: key);

  final List<PetModel> listPetsModel;

  @override
  Widget build(BuildContext context) {
    Get.put(OtherUserProfileControllerImp);
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listPetsModel.length,
        itemBuilder: (context, index) {
          return GetBuilder<OtherUserProfileControllerImp>(
            init: OtherUserProfileControllerImp(listPetsModel[index].userID!), // Add this line
            builder: (controller) => CustomPetWidgetProfile(
              petName: '${listPetsModel[index].name}',
              petImage: '${listPetsModel[index].image}',
              onPressed: () {
                controller.selectedIndex = index;
                controller.openPopUpPetInfoFromPetlList(petModel: listPetsModel[index]);
              },

            ),
          );
        },
      ),
    );
  }
}
