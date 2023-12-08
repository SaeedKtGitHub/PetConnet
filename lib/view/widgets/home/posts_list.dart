
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';
class PostsList extends StatelessWidget {
  final List<PostWidget> posts;

  const PostsList({required this.posts,super.key});

  @override
  Widget build(BuildContext context) {
    return

       ListView.builder(
           //primary: false,
            shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.only(top: 10.0.h),
                  child: PostWidget(
                    date: posts[index].date,
                    image: posts[index].image,
                    title: posts[index].title,
                    animalIcon: posts[index].animalIcon,
                    user: posts[index].user,
                    content: posts[index].content,
                    tags: posts[index].tags,
                  ),
                );
              },

          )


    ;
  }
}