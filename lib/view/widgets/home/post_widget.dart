import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/home/custom_button.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  final void Function()? onImageTap;
  final void Function()? onDeletePost;
  final void Function()? onLikeTap;
  final void Function()? onCommentTap;
  final void Function()? onProfilePicTap;
  final void Function()? onContactMeTap;

  const PostWidget({
    super.key,
    required this.post,
    required this.onImageTap,
    required this.onDeletePost,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onProfilePicTap,
    required this.onContactMeTap,

});


  @override
  State<PostWidget> createState() => _PostWidgetState();

}

class _PostWidgetState extends State<PostWidget> {
  bool isLike=false;
  int numberOfLikes=0;
  get getNumberOfLikes =>numberOfLikes.toString();

  @override
  void initState() {
    // TODO: implement initState
    isLike= widget.post.likes!.contains(currentUserId);
    numberOfLikes=widget.post.likes!.length;
    super.initState();
  }


    @override
  Widget build(BuildContext context) {
       // Toggle like:
      void toggleLike() {

        setState(() {
          numberOfLikes += isLike ? -1 : 1;
          isLike = !isLike;
        });
       // widget.onLikeTap;// Assuming this method triggers a rebuild in your setup
      }
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(
        children: [
          // The date:
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 5.0.w),
                child: Text(
                  formattedDate(widget.post.date!),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),

          //The post image
          Stack(
            children: [
              // Image
              GestureDetector(
                onTap: widget.onImageTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0.h),
                  child: Image.network(
                    "${AppLink.linkImageRoot}/${widget.post.image}",
                    width: 340.w,
                    height: 230.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              // Delete icon (x) at the top right
              //to enable the user owner to delete his posts
              if(widget.post.userID==currentUserId)
              Positioned(
                top: 6.0.h,
                right: 8.0.w,
                child: GestureDetector(//to delete the post
                  onTap: widget.onDeletePost,
                  child: Container(
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor, // Customize the delete icon color
                    ),
                    //padding: EdgeInsets.all(8.0.h),
                    child: Icon(
                      Icons.clear,
                      color: Colors.white, // Customize the delete icon color
                      size: 23.h, // Customize the delete icon size
                    ),
                  ),
                ),
              ),
            ],
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
                // CircleAvatar(
                //   //   backgroundColor:Colors.white,
                //   radius: 16.h, // Adjust the radius as needed
                //   child: Icon(
                //     Icons.person,
                //     color: AppColor.primaryColor,
                //     size: 21.h, // Adjust the icon size as needed
                //   ),
                // ),
                GestureDetector(
                  onTap: widget.onProfilePicTap,
                  child: CircleAvatar(
                    backgroundImage: widget.post.profilePic == null
                        ? null
                        : NetworkImage("${AppLink.linkImageRoot}/${widget.post.profilePic}"),
                    radius: 16.h, // Adjust the radius as needed
                    child: widget.post.profilePic == null
                        ? Icon(
                      Icons.person,
                      color: AppColor.primaryColor,
                      size: 24.h, // Adjust the icon size as needed
                    )
                        : null,  // No child for non-null profilePic
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                //The user name
                Text(
                  widget.post.username!,
                  //textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                //  Animal name
                Text(
                  widget.post.petModel!.name!, // Replace "Default Name" with a suitable default value
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
            height: 10.h,
          ),

          Padding(
            padding:  EdgeInsets.only(left:10.w,right: 10.w),
            child: Row(
              children: [
                //like icon (love)
                GestureDetector(
                  onTap: () {
                    toggleLike();
                    widget.onLikeTap?.call(); // Call the onLikeTap callback
                  },
              // toggleLike;
              // widget.onLikeTap;
                  child: isLike==true
                      ? Icon(Icons.favorite, size: 20.h, color: AppColor.primaryColor)
                      : Icon(Icons.favorite_outline, size: 20.h),
                ),
                SizedBox(width:2.w ,),
                //like number
                Text(getNumberOfLikes),
                SizedBox(width:10.w ,),
                //comment  icon
                GestureDetector(
                    onTap: widget.onCommentTap,
                    child: Icon(Icons.comment_outlined,size: 20.h,)),
                SizedBox(width:2.w ,),
                //comment  number
                Text(widget.post.comments!.length.toString()),
                const Spacer(),

                widget.post.tag != 'social' ?
                Row(
                      children: [
                        if(widget.post.tag =='trading')
                        //Price text row
                          Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Row(
                                children: [
                                  Text(
                                    '93'.tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    ' ${widget.post.price.toString()} ${'105'.tr} ',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.primaryColor,
                                    ),
                                  )
                                ],
                              )
                          ),
                        //contact me button
                        Padding(
                          padding:  EdgeInsets.only(left: 1.0.w),
                          child: CustomButton(
                              onPressed:(){
                                widget.onContactMeTap!.call();
                              },
                              buttonText: '67'.tr),
                        ),
                      ],
                    )


                    ://not social
                Container(),


              ],
            ),
          ),



          SizedBox(
            height: 12.h,
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
