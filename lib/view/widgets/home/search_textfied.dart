import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_connect/controller/articles_controller.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/routes.dart';

class BuildSearchTextField extends StatefulWidget {
  const BuildSearchTextField({Key? key, required this.onCloseSearch}) : super(key: key);
  final  void Function() onCloseSearch;

  @override
  State<BuildSearchTextField> createState() => _BuildSearchTextFieldState();
}

class _BuildSearchTextFieldState extends State<BuildSearchTextField> {
  ArticlesControllerImp articlesControllerImp = Get.find<ArticlesControllerImp>();
  //Timer? _debounce;
  @override
  Widget build(BuildContext context) {


    print('buillllld');
    HomeControllerImp homeController = Get.find<HomeControllerImp>();
    return  Visibility(
      visible: Get.currentRoute == AppRoute.articlesScreen
          ? articlesControllerImp.isSearching
          : Get.currentRoute == AppRoute.homeScreen
          ? homeController.isSearchingInHome
          : homeController.isSearchingInDynamic,

      child: TextField(
        onChanged: (query) {
          //_debounce?.cancel(); // Cancel the previous timer

          if(Get.currentRoute==AppRoute.homeScreen ) {
            homeController.getSearchedPosts(query: query,limit: 12); // Make sure this method is correctly implemented
          }else if(Get.currentRoute==AppRoute.articlesScreen){
            articlesControllerImp.getSearchedArticles(query: query,limit: 12);
          }
          else{//dynamic (filters screens)
            homeController.searchPosts(query);
          }

        },
        decoration: InputDecoration(
          hintText:Get.currentRoute==AppRoute.articlesScreen ?'117'.tr
              :  '116'.tr,
          prefixIcon: IconButton(
            icon: Icon(Icons.search,color: AppColor.primaryColor,),
            onPressed:widget.onCloseSearch,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.close,color: AppColor.primaryColor,),
            onPressed:widget.onCloseSearch,
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
   // _debounce?.cancel();
    super.dispose();
  }
}
