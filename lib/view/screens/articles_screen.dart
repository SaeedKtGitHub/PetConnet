import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:pet_connect/core/class/handling_data_view.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/link_api.dart';
import 'package:pet_connect/view/widgets/articles/articles_list.dart';
import 'package:pet_connect/view/widgets/home/bottom_navigation_bar.dart';
import 'package:pet_connect/view/widgets/home/floating_action_button.dart';
import 'package:pet_connect/view/widgets/home/search_textfied.dart';



class ArticlesScreen extends StatefulWidget {

  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late  HomeControllerImp homeController;
  late  ArticlesControllerImp articlesControllerImp;
  @override
  Widget build(BuildContext context) {
     homeController = Get.find<HomeControllerImp>();
     articlesControllerImp = Get.put(ArticlesControllerImp());

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    return Scaffold(

      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(onPressed: homeController.showChoosePostTypePopUp),

      //bottomNavigationBar
      bottomNavigationBar:  CustomBottomNavigationBar(
        currentIndex: homeController.currentNavIndex,
        onItemTapped: homeController.onItemTapped,
        onGalleryTap:()async {
          await  homeController.getFilteredPosts(tag: 'social');
          homeController.goToDynamicScreen('65'.tr, posts:homeController.filteredPosts,
          );
          homeController.resetSearchRefresh();
        },
        onHomeTap: () {
          if (Get.currentRoute ==AppRoute.homeScreen) {
            homeController.scrollToTop();
          } else {
            Get.offNamed(AppRoute.homeScreen);
          }
        },
        onSettingsTap: (){
          if (Get.currentRoute ==AppRoute.homeScreen) {
            Get.toNamed(AppRoute.settingsScreen);
          }else{
            Get.offNamed(AppRoute.settingsScreen);

          }

        },
        onProfieTap:  homeController.goToProfilePage,
      ),
      body : SafeArea(
        child: GetBuilder<ArticlesControllerImp>(
          builder: (controller)=>
              HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    // Trigger the refresh by calling getComments
                    await articlesControllerImp.getAllArticles();
                    articlesControllerImp.isSearching=false;
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      //  First row with an icon and title
                      Padding(
                        padding: EdgeInsets.only(right: 15.0.w),
                        child:articlesControllerImp.isSearching==true ?
                        BuildSearchTextField(
                          onCloseSearch:(){
                            articlesControllerImp.cancelSearch();
                          },
                        )
                            : Row(
                          children: [
                            //back Icon
                            InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Image.asset(
                                AppImageAsset.backIcon,
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),

                            SizedBox(
                              width: 12.w,
                            ),
                            //The title (depending on filter (tag)):
                            Text(
                              'آخر المقالات والأخبار',
                              //textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            //The The search icon :
                            Padding(
                              padding: EdgeInsets.only(left: 12.0.w),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    controller.isSearching = !controller.isSearching; // Toggle the search state
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


                      //Your list of articles
                       controller.isSearching ?
                       ArticlesList(
                           articles: articlesControllerImp.filteredArticles)
                       :ArticlesList(
                            articles: articlesControllerImp.articles),

                    ],
                  ),
                ),
              ),
        ),
      ),

    );
  }
  @override
  void dispose() {
    // Set isSearching to false when the screen is disposed
    articlesControllerImp.isSearching = false;
    super.dispose();
  }
}
