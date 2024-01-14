import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/commentsController.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/controller/post/create_post_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/functions/alert_exit_app.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/screens/view_article_Screen.dart';
import 'package:pet_connect/view/widgets/articles/article_widget.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/custom_button.dart';
import 'package:pet_connect/view/widgets/home/demo_two_images.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/image_slider.dart';
import 'package:pet_connect/view/widgets/home/posts_list.dart';
import 'package:pet_connect/view/widgets/home/search_textfied.dart';
import 'package:pet_connect/view/widgets/home/text_and_button_row.dart';

class  HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeControllerImp controller = Get.put(HomeControllerImp());
  @override
  Widget build(BuildContext context) {
    print('its faaaaaaaaalse');
    ArticlesControllerImp articlesController = Get.put(ArticlesControllerImp());
    MyServices myServices = Get.find();
    String filePath =
        myServices.sharedPreferences.getString('profilePic') ?? '';
      Get.lazyPut(() => CommentsControllerImp());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    Get.put(CreatePostControllerImp());

  return Scaffold(
        //FAB:
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomFloatingActionButton(
            onPressed: controller.showChoosePostTypePopUp),

        //bottomNavigationBar:
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: controller.currentNavIndex,
          onItemTapped: controller.onItemTapped,
          onGalleryTap: () async {
            await controller.getFilteredPosts(tag: 'social');
            controller.goToDynamicScreen(
              '65'.tr,
              posts: controller.filteredPosts,
              tag:"social"
            );
            controller.resetSearchRefresh();
          },
          onHomeTap: controller.scrollToTopOrGoHome,
          onSettingsTap: controller.goToSettingsScreen,
          onProfieTap: controller.goToProfilePage,
        ),
        body: WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<HomeControllerImp>(
            builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  // Trigger the refresh by calling getComments
                  await controller.getAllPosts();
                  controller.isSearchingInHome=false;
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child:
                    controller.isSearchingInHome?
                        Column(
                          children: [
                            //First row:
                            //The welcome message :
                            Padding(
                              padding: EdgeInsets.only(right: 15.0.w),
                              child:controller.isSearchingInHome ?
                              BuildSearchTextField(
                                onCloseSearch:(){
                                  controller.cancelSearch();
                                },
                              )
                                  : Row(
                                children: [
                                  //The Icon:
                                  GestureDetector(
                                    onTap: controller.goToProfilePage,
                                    child: CircleAvatar(
                                      backgroundImage: controller
                                          .currentUser.profilePic ==
                                          null
                                          ? null
                                          : NetworkImage(
                                          "${AppLink.linkImageRoot}/$filePath"),
                                      radius: 16.h, // Adjust the radius as needed
                                      child: controller.currentUser.profilePic == null
                                          ? Icon(
                                        Icons.person,
                                        color: AppColor.primaryColor,
                                        size: 24
                                            .h, // Adjust the icon size as needed
                                      )
                                          : null, // No child for non-null profilePic
                                    ),
                                  ),

                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  //The text:
                                  Text(
                                    "${'100'.tr} ${myServices.sharedPreferences.getString("username")!}!",
                                    //textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0.w),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          controller.isSearchingInHome = !controller.isSearchingInHome; // Toggle the search state
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 15.h,
                                        backgroundImage: AssetImage(AppImageAsset.searchIcon,),
                                      ),
                                    ),
                                  ),],
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            controller.statusRequest==StatusRequest.loading ?
                                CircularProgressIndicator() :
                            PostsList(posts: controller.searchResults)
                          ],
                        )
                    ://not searching
                    Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        //The welcome message :
                        Padding(
                          padding: EdgeInsets.only(right: 15.0.w,left: 15.w),
                          child:controller.isSearchingInHome ?
                          BuildSearchTextField(
                            onCloseSearch:(){
                              controller.cancelSearch();
                            },
                          )
                              : Row(
                            children: [
                              //The Icon:
                              GestureDetector(
                                onTap: controller.goToProfilePage,
                                child: CircleAvatar(
                                  backgroundImage: controller
                                              .currentUser.profilePic ==
                                          null
                                      ? null
                                      : NetworkImage(
                                          "${AppLink.linkImageRoot}/$filePath"),
                                  radius: 16.h, // Adjust the radius as needed
                                  child: controller.currentUser.profilePic == null
                                      ? Icon(
                                          Icons.person,
                                          color: AppColor.primaryColor,
                                          size: 24.h, // Adjust the icon size as needed
                                        )
                                      : null, // No child for non-null profilePic
                                ),
                              ),

                              SizedBox(
                                width: 8.w,
                              ),
                              //The text:
                              Text(
                                // "مرحبا, ${controller.currentUser.name}!",
                                "${'100'.tr} ${myServices.sharedPreferences.getString("username")!}!",
                                //textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0.w),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      controller.isSearchingInHome = !controller.isSearchingInHome; // Toggle the search state
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 15.h,
                                    backgroundImage: AssetImage(AppImageAsset.searchIcon,),
                                  ),
                                ),
                              ),],
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        //All articles line:
                        Padding(
                          padding: EdgeInsets.only(right: 10.0.w,left: 15.w),
                          child: Row(
                            children: [
                              Text(
                                '58'.tr,
                                //textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:  EdgeInsets.only(left: 10.0.w,right: 10.w),
                                child: CustomButton(
                                    onPressed: controller.goToAllArticlesScreen,
                                    buttonText: '94'.tr),
                              ),
                            ],
                          ),
                        ),

                        //The image slider
                        MyImageSlider(
                          articles: articlesController.articles
                              .map((article) => ArticleWidget(
                                  onTap: () {
                                    Get.to(ViewArticlesScreen(
                                        article: articlesController.articles[
                                            controller.currentSliderIndex]));
                                  },
                                  article: article))
                              .toList(),
                        ),

                        //pets for sale list
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w,left: 10.w),
                          child: TextAndButtonRow(
                            text: '59'.tr,
                            onPressed: () async {
                              await controller.getFilteredPosts(tag: 'trading');
                              controller.goToDynamicScreen(
                                '63'.tr,
                                posts: controller.filteredPosts,
                                tag: "trading"
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        GestureDetector(
                            onTap:() async {
                              await controller.getFilteredPosts(tag: 'trading');
                              controller.goToDynamicScreen(
                                  '63'.tr,
                                  posts: controller.filteredPosts,
                                  tag: "trading"
                              );
                            } ,
                           // child:
                            //TwoImagesRow(firstImageUrl: controller.recentPosts[4].image!,secondImageUrl: controller.recentPosts[5].image!)),
                            child: TwoImagesRow(
                        firstImageUrl: controller.recentPosts.length > 0 ? controller.recentPosts[0].image! : '',
                          secondImageUrl: controller.recentPosts.length > 1 ? controller.recentPosts[1].image! : '',
                        ),
                           ),
                        SizedBox(
                          height: 7.h,
                        ),

                        //pets for adoption list
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w,left: 10.w),
                          child: TextAndButtonRow(
                              text: '60'.tr,
                              onPressed: () async {
                                await controller.getFilteredPosts(
                                    tag: 'adoption');
                                controller.goToDynamicScreen(
                                  '60'.tr,
                                  posts: controller.filteredPosts,
                                  tag: "adoption"
                                );
                              }),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),

                        GestureDetector(
                            onTap:() async {
                              await controller.getFilteredPosts(
                                  tag: 'adoption');
                              controller.goToDynamicScreen(
                                  '60'.tr,
                                  posts: controller.filteredPosts,
                                  tag: "adoption"
                              );
                            } ,
                          child: TwoImagesRow(
                            firstImageUrl: controller.recentPosts.length > 8 ? controller.recentPosts[8].image! : '',
                            secondImageUrl: controller.recentPosts.length > 9 ? controller.recentPosts[9].image! : '',
                          ),),
                        SizedBox(
                          height: 7.h,
                        ),
                        //pets for mating list
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w,left: 10.w),
                          child: TextAndButtonRow(
                              text: '61'.tr,
                              onPressed: () async {
                                await controller.getFilteredPosts(tag: 'mating');
                                controller.goToDynamicScreen(
                                  '66'.tr,
                                  posts: controller.filteredPosts,
                                    tag: "mating"
                                );
                              }),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),

                        GestureDetector(
                            onTap: () async {
                              await controller.getFilteredPosts(tag: 'mating');
                              controller.goToDynamicScreen(
                                  '66'.tr,
                                  posts: controller.filteredPosts,
                                  tag: "mating"
                              );
                            },
                           // child: TwoImagesRow(firstImageUrl: controller.recentPosts[8].image!,secondImageUrl: controller.recentPosts[9].image!)),
                        child: TwoImagesRow(
                          firstImageUrl: controller.recentPosts.length > 4 ? controller.recentPosts[4].image! : '',
                          secondImageUrl: controller.recentPosts.length > 5 ? controller.recentPosts[5].image! : '',
                        ),),
                        SizedBox(
                          height: 7.h,
                        ),
                        // lost pets  list
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w,left: 10.w),
                          child: TextAndButtonRow(
                              text: '62'.tr,
                              onPressed: () async {
                                await controller.getFilteredPosts(tag: 'lost');
                                controller.goToDynamicScreen(
                                  '64'.tr,
                                  posts: controller.filteredPosts,
                                    tag: "lost"

                                );
                              }),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),

                        GestureDetector(
                            onTap:  () async {
                              await controller.getFilteredPosts(tag: 'lost');
                              controller.goToDynamicScreen(
                                  '64'.tr,
                                  posts: controller.filteredPosts,
                                  tag: "lost"
                              );
                            },
                            child: TwoImagesRow(
                              firstImageUrl: controller.recentPosts.length > 2 ? controller.recentPosts[2].image! : '',
                              secondImageUrl: controller.recentPosts.length > 3 ? controller.recentPosts[3].image! : '',
                            )),
                        SizedBox(
                          height: 7.h,
                        ),

                        //Favorite animals row
                        Padding(
                          padding: EdgeInsets.only(right: 13.0.w,left: 13.w),
                          child: Row(
                            children: [
                              Text(
                                "92".tr,
                                //textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Spacer(),
                              //all posts
                              Padding(
                                padding:  EdgeInsets.only(left: 8.0.w,right: 8.w),
                                child: CustomButton(
                                    onPressed: () async {
                                      await controller.getAllPosts();
                                      controller.goToDynamicScreen(
                                        '65'.tr,
                                        posts: controller.allPosts,

                                      );
                                    },
                                    buttonText: '95'.tr),
                              ),
                            ],
                          ),
                        ),

                       // controller.isSearching ?
                       // PostsList(posts: controller.searchResults)
                           // :
                        //List of posts:
                        controller.allPosts.isNotEmpty
                            ? PostsList(posts: controller.allPosts)
                            : Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: Center(
                                  child: Text(
                                    "113".tr,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
  @override
  void dispose() {
    // Set isSearching to false when the screen is disposed
    controller.isSearchingInHome = false;
    super.dispose();
  }

}
