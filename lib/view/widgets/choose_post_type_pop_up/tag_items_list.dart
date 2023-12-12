import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/tag_item.dart';

class TagItemList extends StatelessWidget {
  final List<TagItem> tagItems;

  TagItemList({required this.tagItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h), // Set margin for the entire list
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: tagItems.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: TagItem(
                onPressed: (){
                  print(tagItems[index].text);
                },
                iconPath: tagItems[index].iconPath,
                text: tagItems[index].text,
              ),
            );
          },
        ),
      ),
    );
  }
}
