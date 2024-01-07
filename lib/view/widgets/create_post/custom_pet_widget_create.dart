import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/link_api.dart';

class CustomPetWidgetCreate extends StatelessWidget {
  //TODO: USE PetModel
  const CustomPetWidgetCreate({
    Key? key,
    // required this.petIcon,
    required this.petImage,
    required this.petName,
    required this.color,
    required this.onPressed,
    this.onLongPress,
    this.paddingNum,
    this.removeIcon,
  }) : super(key: key);

  //final String petIcon;
  final String petImage;
  final String petName;
  final String? removeIcon;
  final Color color;
  final double? paddingNum;
  final void Function()? onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    //Get.put(CreatePostControllerImp());
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
                child: Container(
                  padding: EdgeInsets.all(paddingNum!),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: CircleAvatar(
                    radius: 45.0,
                    backgroundImage:
                        NetworkImage("${AppLink.linkImageRoot}/$petImage"),
                  ),
                ),
              ),
              // CircleAvatar(
              //   backgroundColor: AppColor.primaryColor,
              //   radius: 14.h, // Adjust the radius as needed
              //   child: Image.asset(
              //     removeIcon!,
              //     width: 20.w,
              //     height: 20.h,
              //     color: AppColor.white,
              //   ),
              // ),
            ],
          ),
          GetBuilder<CreatePostControllerImp>(
            builder: (controller) => Text(
              petName,
              style: TextStyle(
                  fontSize: 18.sp, fontWeight: FontWeight.w500, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
