import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/model/post_model.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/dynamic_posts_list.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';
import 'package:pet_connect/view/widgets/home/search_textfied.dart';


class DynamicViewScreen extends StatefulWidget {
  final String title;
  final List<PostModel> posts;
  final  String? tag;
  const DynamicViewScreen({super.key, required this.title, required this.posts,this.tag});

  @override
  State<DynamicViewScreen> createState() => _DynamicViewScreenState();
}

class _DynamicViewScreenState extends State<DynamicViewScreen> {

  late CommentsControllerImp commentsControllerImp;
  HomeControllerImp homeController = Get.find<HomeControllerImp>();

  @override
  void initState() {
    super.initState();
    // Check if commentsControllerImp is already initialized
    if (!Get.isRegistered<CommentsControllerImp>()) {
      // Lazy initialize if not already initialized
      Get.lazyPut(() => CommentsControllerImp());
    }
    // Retrieve the instance of CommentsControllerImp
    commentsControllerImp = Get.find<CommentsControllerImp>();
  }
  @override
  Widget build(BuildContext context) {

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    return  Scaffold(

        //FAB
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingActionButton(onPressed: homeController.showChoosePostTypePopUp),

        //bottomNavigationBar
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: homeController.currentNavIndex,
          onItemTapped: homeController.onItemTapped,
          onGalleryTap:()async {
            await  homeController.getFilteredPosts(tag: 'social');
            homeController.goToDynamicScreen('65'.tr, posts:homeController.filteredPosts,
                tag: "social"

            );
            homeController.resetSearchRefresh();
          },
          onHomeTap:homeController.scrollToTopOrGoHome,
          onSettingsTap:homeController.goToSettingsScreen,
          onProfieTap:  homeController.goToProfilePage,
        ),
        body : SafeArea(
          child:widget.posts.isNotEmpty ?
          GetBuilder<HomeControllerImp>(
              builder: (controller)=>
                  HandlingDataRequest(
                   statusRequest: controller.statusRequest,
                    widget: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        // Trigger the refresh by calling getComments
                        await controller.getFilteredPosts(tag: widget.tag!);
                        homeController.isSearchingInDynamic=false;
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10.h,),
                          //  First row with an icon and title
                          Padding(
                            padding: EdgeInsets.only(right: 12.0.w,left: 12.w),
                            child:homeController.isSearchingInDynamic ?
                            BuildSearchTextField(
                              onCloseSearch:(){
                                homeController.cancelSearch();
                              },
                            )
                                : Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    AppImageAsset.backIcon,
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0.w),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        homeController.isSearchingInDynamic = !homeController.isSearchingInDynamic; // Toggle the search state
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 15.h,
                                      backgroundImage: AssetImage(AppImageAsset.searchIcon,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Your list of posts if the user is searching
                          homeController.isSearchingInDynamic ?
                          DynamicPostsList(posts: controller.searchResults)
                        // Your list of posts
                           :DynamicPostsList(posts: controller.filteredPosts),

                                    ],
                                  ),
                    ),
                  ),
            ):
             Center(
              child: Text('113'.tr),
            )
        ),


    );
  }
  @override
  void dispose() {
    //HomeControllerImp homeController = Get.find<HomeControllerImp>();
    homeController.isSearchingInDynamic = false;
    super.dispose();
  }

}
