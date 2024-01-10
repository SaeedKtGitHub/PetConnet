import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/color.dart';
import 'package:pet_connect/data/model/article_model.dart';
import 'package:pet_connect/link_api.dart';

class ArticleWidget extends StatelessWidget {
  // final String imagePath;
  // final String text;
  // final String writer;
 final ArticleModel article;
 final void Function() onTap;
  const ArticleWidget({
    Key? key,
    required this.article,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0.h),
            child: Image.network(
              //article.image!,
              "${AppLink.linkImageRoot}/${article.image}",
              //AppImageAsset.testDog,
              width: double.infinity,
              height: 170.h,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.h),
              color: Colors.black.withOpacity(0.3), // Adjust the opacity as needed
            ),
              width: double.infinity,
              child:Padding(
                padding:  EdgeInsets.only(right: 10.0.w,left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h,),
                    Text(
                    article.title!,
                      style: TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                          article.author!,
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                          textAlign: TextAlign.right,
                        ),
                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }
}
