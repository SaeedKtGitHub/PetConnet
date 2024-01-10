import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/link_api.dart';

class TwoImagesRow extends StatelessWidget {
  final String firstImageUrl;
  final String secondImageUrl;

  const TwoImagesRow({
    super.key,
    required this.firstImageUrl,
    required this.secondImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 10.0.w, left: 10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0.h),
              child: Image.network(
                '${AppLink.linkImageRoot}/$firstImageUrl',
                width: 165.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0.h),
              child: Image.network(
                '${AppLink.linkImageRoot}/$secondImageUrl',
                width: 165.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
