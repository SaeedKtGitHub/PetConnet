import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/data/model/user_model.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(
        children: [
          // The date:
          // Row(
          //   children: [
          //     Padding(
          //       padding:  EdgeInsets.only(right: 5.0.w),
          //       child: Text(
          //         widget.post.date!,
          //         textAlign: TextAlign.right,
          //         style: TextStyle(
          //           color: Colors.grey[700],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 2.h,
          ),

          //The image

          ClipRRect(
            borderRadius: BorderRadius.circular(5.0.h),
            child: Image.asset(
              widget.post.image!,
              width: 340.w,
              height: 230.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          //Row of username,image user ,animal icon ,post title
          Padding(
            padding: EdgeInsets.only(right: 6.0.w, left: 6.w),
            child: Row(
              children: [
                //The user image
                CircleAvatar(
                  //   backgroundColor:Colors.white,
                  radius: 16.h, // Adjust the radius as needed
                  child: Icon(
                    Icons.person,
                    color: AppColor.primaryColor,
                    size: 21.h, // Adjust the icon size as needed
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                //The user name
                Text(
                  widget.post.name!,
                  //textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                //  The title
                Text(
                  widget.post.title!,
                  //textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 3.w,
                ),
                //The animal icon
                //  Image.asset(
                //   widget.post.animalIcon!,
                //   width: 17 .w,
                // ),
              ],
            ),
          ),
          //The post content:
          Text(
            widget.post.content!,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(
            height: 18.h,
          ),

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
