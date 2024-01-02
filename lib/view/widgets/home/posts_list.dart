import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';

class PostsList extends StatelessWidget {
  final List<PostModel> posts;
  final HomeControllerImp controller = Get.find<HomeControllerImp>(); // Get instance of HomeController

   PostsList({required this.posts, super.key});

  @override

  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      //primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: PostWidget(
            post: posts[index],
            onImageTap: (){
              controller.openPopUpPetInfo(petModel: posts[index].petModel!,
                  index: index);
            },
          ),
        );
      },
    );
  }
}
