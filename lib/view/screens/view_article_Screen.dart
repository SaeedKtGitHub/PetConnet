import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/functions/helper_methods.dart';
import 'package:pet_connect/data/model/article_model.dart';
import 'package:pet_connect/link_api.dart';
// Import the necessary class/file

class ViewArticlesScreen extends StatelessWidget {
  const ViewArticlesScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              //The back icon
              Padding(
                padding:  EdgeInsets.only(right:16.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: ()=>Get.back(),
                      child: Image.asset(
                        AppImageAsset.backIcon,
                        height: 25.h,
                        width: 25.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              // The image:
             Image.network(
                  "${AppLink.linkImageRoot}/${article.image}",
                  width: double.infinity,
                  height: 150.0.h,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 10.h,),
                  //article title
                  Padding(
                    padding:  EdgeInsets.only(right: 12.0.w),
                    child: Row(
                      children: [
                        Text(
                          article.title!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black),
                        ),
                      ],
                    ),
                  ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 12.0.w,left: 12.w),
                child: Row(
                  children: [
                    Text(
                      'من: ',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black),
                    ),
                    Text(
                      '${article.author}',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                    SizedBox(width: 3.w,),
                    Image.asset(AppImageAsset.articleIcon,width: 22.w,height: 22.h,),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Text(formattedDate(article.date!)),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 17.h,),
              Divider(
                color: Colors.grey[500],
                thickness: 1.0.h,
                height: 0,
                endIndent: 50.w,
                indent: 50.w,
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(left:11.w,right: 11.w),
                child: Text(
                  article.content!,
                  style:  TextStyle(
                      fontSize: 14.sp,
                     // fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
              ),
              //back Icon

              // Add other widgets to display additional information about the article if needed
            ],
          ),
        ),
      ),
    );
  }
}
