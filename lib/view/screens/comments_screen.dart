import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/valid_input.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/data/model/comment.dart';
import 'package:pet_connect/view/widgets/comments/comment_textfeld.dart';
import 'package:pet_connect/view/widgets/comments/comments_list.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key, required this.comments}) : super(key: key);
  final List<CommentModel> comments;
  @override
  State<CommentsScreen> createState() => _ChoosePostTypePopUpState();
}

class _ChoosePostTypePopUpState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    CommentsControllerImp commentsControllerImp = Get.find<CommentsControllerImp>();
    HomeControllerImp homeControllerImp = Get.find<HomeControllerImp>();
    MyServices myServices = Get.find();
// Add a GlobalKey for RefreshIndicator
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    return Container(
      height: 545.h,
      width: 550.w,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: GetBuilder<CommentsControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          
          widget: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              // Trigger the refresh by calling getComments
              await controller.getComments(controller.getCurrentPostId);
            },
            child:Column(
                children: [
                  SizedBox(height: 10.h,),
                  //first row :
                  Row(
                    children: [
                      SizedBox(width: 5.w,),
                      //The cancel button
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.w),
                          child: Image.asset(
                            AppImageAsset.backIcon,
                            width: 25.0.w,
                            height: 25.0.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 50.w),
                      //The title:
                      Text(
                        'التعليقات',
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  //SizedBox(height: 50.h,),
                  //list of comments:
                  Expanded(
                    child: widget.comments.isNotEmpty
                        ? CommentsList(comments: widget.comments)
                        : const Center(child: Text('لا يوجد تعليقات')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.w, bottom: 5.h,left: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //   SizedBox(width: 15.w,),
                        Form(
                          key: controller.formState,
                          child: CommentTextField(
                            isNumber: false,
                            valid: (val) {
                              return validInput(val!, 1, 800, 'text');
                            },
                            iconData: Icons.text_fields_outlined,
                            myController: controller.comment,
                            hintText: '91'.tr,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool success = await controller.addComment(controller.currentPostId.value);
                            if (success) {
                              setState(() {
                              });

                            }
                            },
                          icon: const Icon(Icons.send,color: AppColor.primaryColor,),
                        ),
              
                      ],
                    ),
                  ),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
