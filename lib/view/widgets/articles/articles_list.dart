import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/data/model/article_model.dart';
import 'package:pet_connect/view/screens/view_article_Screen.dart';
import 'package:pet_connect/view/widgets/articles/article_widget.dart';

class ArticlesList extends StatelessWidget {
  final List<ArticleModel> articles;

  const ArticlesList({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: articles.length,

        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 13.0.h,right: 15.w,left: 15.w),
            child: ArticleWidget(article: articles[index],
            onTap:(){
              Get.to(ViewArticlesScreen(article: articles[index]));
            } ,
            ),
          );
        },
      ),
    );
  }
}
