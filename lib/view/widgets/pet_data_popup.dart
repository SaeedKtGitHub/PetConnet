import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/create_post/animal_data_row_popup.dart';

class AnimalDataPopup extends StatelessWidget {
   final PetModel petModel;
   const AnimalDataPopup({Key? key,
  required this.petModel
  }) : super(key: key
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.h,
      width: 340.w,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Center(
        child: Column(
            children: [
              //pet name and cancel row :
              Row(
                children: [
                  //The cancel button
                  GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(
                      AppImageAsset.cancel,
                      width: 43.0.w,
                      height: 43.0.h,
                    ),
                  ),
                  //The title:
                  Padding(
                    padding: EdgeInsets.only(right: 80.0.w),
                    child: Text(
                      petModel.name!,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 8.h,),
              //animal image:
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0.h),
                child: Image.network(
                  // 'linkImageRoot/widget.post.image!',
                  "${AppLink.linkImageRoot}/${petModel.image}",
                  width: 245.w,
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h,),

              //animal data:
              AnimalDataRow(info:petModel.type!, category: '118'.tr),
              AnimalDataRow(info:petModel.gender!, category: '119'.tr,genderIcon: getIconGender(gender: petModel.gender!)),
              AnimalDataRow(info:calculateAge(petModel.birthDate!), category: '120'.tr),
              AnimalDataRow(info:petModel.breed!, category:'121'.tr),

            ],
          ),
      ),



    );

  }
}
