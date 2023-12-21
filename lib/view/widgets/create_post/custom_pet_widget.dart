import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/constant/color.dart';

class CustomPetWidget extends StatelessWidget {
  //TODO: USE PetModel
  const CustomPetWidget({
    super.key,
    required this.petIcon,
    required this.petImage,
    required this.petName,
    required this.index,
    //required this.petModel,
    required this.onPressed,
    required this.onLongPress,
  });
  final int index;
  final String petIcon;
  final String petImage;
  final String petName;
  // final PetModel petModel =
  //     PetModel(petId: '1', petImage: AppImageAsset.testDog, petName: 'DOG');
  final void Function()? onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              InkWell(
                onTap: onPressed,
                onLongPress: onLongPress,
                child: CircleAvatar(
                  radius: 45.h,
                  backgroundImage:
                      AssetImage(petImage), // Adjust the radius as needed
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 14.h, // Adjust the radius as needed
                child: Image.asset(
                  petIcon,
                  width: 20.w,
                  height: 20.h,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
          GetBuilder<CreatePostControllerImp>(
            builder: (controller) => Text(
              petName,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: controller.selectedIndex == index
                      ? Colors.red
                      : AppColor.black),
            ),
          ),
        ],
      ),
    );
  }
}
