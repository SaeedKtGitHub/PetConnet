
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/view/widgets/comments/comment_widget.dart';

class CommentsList extends StatefulWidget {
  final List<CommentModel> comments;

  const CommentsList({required this.comments, super.key});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final HomeControllerImp controller = Get.find<HomeControllerImp>();
  final CommentsControllerImp commentsControllerImp = Get.find<CommentsControllerImp>();
  @override

  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.only(bottom: 8.0.h),
      child: ListView.builder(
            //   shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: widget.comments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 10.0.h),
                child: CommentWidget(
                 commentModel: widget.comments[index],
                    onProfilePicTap: (){
                      controller.goToOtherProfilePage(
                        widget.comments[index].userID!,
                        widget.comments[index].profilePic!,
                        widget.comments[index].name!,
                      );
                    },
                  onDeleteComment:(){
                    Get.defaultDialog(
                      titleStyle: const TextStyle(color: AppColor.primaryColor),
                      middleTextStyle:
                      const TextStyle(color: AppColor.black, fontSize: 20),
                      title: 'تنبيه',
                      middleText: 'هل انت متاكد من  حذف هذا التعليق؟',
                      actions: [
                        //no button
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
                        //yes button
                        ElevatedButton(
                            onPressed: () async {
                              Get.back();
                               commentsControllerImp.deleteComment(
                                  commentsControllerImp.getCurrentPostId ,
                                  widget.comments[index].commentId!);

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
                  //  commentsControllerImp.getCurrentPostId

                  },
                ),
              );
            },
          ),
    )

    ;
  }
}
