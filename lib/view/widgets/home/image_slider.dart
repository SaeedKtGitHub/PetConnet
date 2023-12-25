import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/controller/home_controller.dart';
import 'package:get/get.dart';

class MyImageSlider extends StatefulWidget {
  final List<Widget> articles;

  const MyImageSlider({Key? key, required this.articles}) : super(key: key);

  @override
  State<MyImageSlider> createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {


  @override

  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<HomeControllerImp>(
                builder:(controller)=> CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(milliseconds:1500),
                    autoPlayInterval: const Duration(milliseconds: 3500),
                    enlargeCenterPage: true,
                    aspectRatio: 2.0.h,
                    height: 180.h,
                    onPageChanged: (index, reason) {
                      setState(() {
                        controller.setCurrentSliderIndex(index);
                      });
                    },
                    reverse: true,
                  ),
                  items: widget.articles,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
