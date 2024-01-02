import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/profile_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/view/widgets/profile/custom_pet_widget_profile.dart';

class PetsListProfile extends GetView<ProfileControllerImp> {
  const PetsListProfile({
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
              onRemovePet: () {
                // listPetsModel[index].petID;
                // TODO: Refresh list after success remove in controller removeMethod
                print('ON REMOVE PET ====> $index');
                Get.defaultDialog(
                  titleStyle: const TextStyle(color: AppColor.primaryColor),
                  middleTextStyle:
                      const TextStyle(color: AppColor.black, fontSize: 20),
                  title: 'تنبيه',
                  middleText: 'هل تريد حذف هذا الحيوان؟',
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'لا',
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          controller.removePet(index: index);
                          Get.back();
                        },
                        child: const Text(
                          'نعم',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
