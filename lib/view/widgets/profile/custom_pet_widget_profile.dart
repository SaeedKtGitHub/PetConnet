import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/link_api.dart';

class CustomPetWidgetProfile extends StatelessWidget {
  //TODO: USE PetModel
  const CustomPetWidgetProfile({
    Key? key,
    // required this.petIcon,
    required this.petImage,
    required this.petName,
    required this.onPressed,
     this.onRemovePet,
  }) : super(key: key);

  //final String petIcon;
  final String petImage;
  final String petName;
  final void Function()? onPressed;
  final void Function()? onRemovePet;

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
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage:
                      NetworkImage("${AppLink.linkImageRoot}/$petImage"),
                ),
              ),
             if(onRemovePet!=null)
               InkWell(
                onTap: onRemovePet,
                child: CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  radius: 10.h, // Adjust the radius as needed
                  child: Image.asset(
                    AppImageAsset.cancelImageIcon,
                    width: 13.w,
                    height: 13.h,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            petName,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black),
          ),
        ],
      ),
    );
  }
}
