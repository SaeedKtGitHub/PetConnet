import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/data/datasource/static/static.dart';
import 'package:pet_connect/view/widgets/home/build_image_with_text.dart';

class HomeController extends GetxController {

  List<Widget> slider_articles_widgets(List images) {
    List<Widget> list=[];

    for(int i=0;i<images.length;i++){
      list.add(
          BuildImageWithText(
              imagePath: slides[i].imagepath,
              text:slides[i].slideText));
    }
    return list;
  }
  int currentSliderIndex = 0;
  setCurrentSliderIndex(index){
    currentSliderIndex=index;
  }

  int currentNavIndex = 0;


  void onItemTapped(int index) {
       update();
       currentNavIndex = index;

  }

}

