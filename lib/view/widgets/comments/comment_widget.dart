import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/link_api.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.commentModel,
    required this.onProfilePicTap,
    required this.onDeleteComment,

    required
  }) : super(key: key);

  final CommentModel commentModel;
  final void Function()? onProfilePicTap;
final void Function()? onDeleteComment;

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0.w, right: 12.w),
      child: Column(
        children: [
          // row of user image, username, date, delete icon
          Row(
            children: [
              GestureDetector(
                onTap: onProfilePicTap,
                child: CircleAvatar(
                  backgroundImage: commentModel.profilePic == null
                      ? null
                      : NetworkImage("${AppLink.linkImageRoot}/${ commentModel.profilePic}"),
                  radius: 16.h, // Adjust the radius as needed
                  child:  commentModel.profilePic == null
                      ? Icon(
                    Icons.person,
                    color: AppColor.primaryColor,
                    size: 24.h, // Adjust the icon size as needed
                  )
                      : null,  // No child for non-null profilePic
                ),
              ),
              SizedBox(width: 5.w),
              // username
              Text(
                commentModel.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(width: 6.w),
              // date
              Text(
                formattedDate(commentModel.date!),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(width: 5.w),
             // Spacer(),
              if(currentUserId==commentModel.userID)
              GestureDetector(
                  onTap: onDeleteComment,
                  child:  Icon(Icons.dangerous_sharp,color: Colors.grey[500],)),
            ],
          ),
          SizedBox(height: 10.h),
          // comment text container
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 12.0.w),
                  child: Container(
                    padding: EdgeInsets.all(8.0.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                       commentModel.content!,

                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
