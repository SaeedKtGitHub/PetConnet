import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimalDataRow extends StatelessWidget {
  const AnimalDataRow({
    Key? key,
    required this.info,
    required this.category,
    this.genderIcon, // Make genderIcon optional with a default value of null
  }) : super(key: key);

  final String category;
  final String info;
  final IconData? genderIcon; // Make IconData nullable

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(right: 30.0.w,left: 30.w),
      child: Column(
        children: [
          Row(
            children: [
              //animal type:
              Text(category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),

              Text(
                info,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),

              SizedBox(width: 4.w,),
              genderIcon != null ? Icon(genderIcon) : Container(),



            ],
          ),
          SizedBox(height: 5.h,),
          //divider:
          Divider(
            color: Colors.grey[300],
            thickness: 0.7.h,
            height: 0,
            endIndent: 8.w,
            indent: 8.w,
          ),
        ],
      ),

    );
  }
}
