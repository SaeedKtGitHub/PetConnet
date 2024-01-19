import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/link_api.dart';

class TwoImagesRow extends StatelessWidget {
  final String firstImageUrl;
  final String secondImageUrl;

  const TwoImagesRow({
    Key? key,
    required this.firstImageUrl,
    required this.secondImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 10.0.w, left: 10.w),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0.h),
                child: Image.network(
                  '${AppLink.linkImageRoot}/$firstImageUrl',
                  width: 165.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0.h),
                child: Image.network(
                  '${AppLink.linkImageRoot}/$secondImageUrl',
                  width: 165.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
