import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/user.dart';

class PostWidget extends StatefulWidget {
  final String date;
  final String image;
  final String title;
  final String animalIcon;
  final User user;
  final String content;
  final List<String> tags;

  const PostWidget({super.key, 
    required this.date,
    required this.image,
    required this.title,
    required this.animalIcon,
    required this.user,
    required this.content,
    required this.tags,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.h),
      child: Column(
        children: [
          // The date:
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 5.0.w),
                child: Text(
                  widget.date,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h,),

          //The image

          ClipRRect(
            borderRadius: BorderRadius.circular(5.0.h),
            child: Image.asset(
              widget.image,
              width: 340.w,
              height: 230.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4.h,),

          //Row of username,image user ,animal icon ,post title
          Row(
            children: [
              //The user image
              const CircleAvatar(
                //   backgroundColor:Colors.white,
                radius: 16, // Adjust the radius as needed
                child: Icon(
                  Icons.person,
                  color: AppColor.primaryColor,
                  size: 22, // Adjust the icon size as needed
                ),
              ),
              SizedBox(width: 3.w,),
              //The user name
              Text(
                widget.user.name,
                //textDirection: TextDirection.rtl,
                style:  TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              //  The title
              Text(
                widget.title,
                //textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 3.w,),
              //The animal icon
               Image.asset(
                widget.animalIcon,
                width: 18.w,
              ),

            ],
          ),
          //The post content:
          Text(
            widget.content,
            //textDirection: TextDirection.rtl,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 14.sp,

            ),
          ),
          SizedBox(height: 18.h,),

          //The divider:
          Divider(
            color: Colors.grey[300],
            thickness: 1.0.h,
            height: 0,
            endIndent: 50.w,
            indent: 50.w,

          ),

        ],
      ),
    );
  }
}
