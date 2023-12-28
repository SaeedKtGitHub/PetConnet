import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_connect/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:pet_connect/core/constant/imageasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? Center(
                child: Column(
                  children: [
                    Text(
                      'No Internet!!',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Image.asset(AppImageAsset.noInternet),
                  ],
                ),
              )
            : statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Column(
                      children: [
                        Text(
                          'Something Went Wrong! try later.',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Image.asset(AppImageAsset.serverFailure),
                      ],
                    ),
                  )
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: Column(
                          children: [
                            Text(
                              'No Data!',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            Image.asset(AppImageAsset.noData),
                          ],
                        ),
                      )
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? Center(
                child: Column(
                  children: [
                    Text(
                      'No Internet!!',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Image.asset(AppImageAsset.noInternet),
                  ],
                ),
              )
            : statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Column(
                      children: [
                        Text(
                          'Something Went Wrong! try later.',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Image.asset(AppImageAsset.serverFailure),
                      ],
                    ),
                  )
                : widget;
  }
}
