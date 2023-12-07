import 'package:pet_connect/core/class/status_request.dart';
import 'package:flutter/material.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: Text('Loading...'))
        : statusRequest == StatusRequest.offlineFailure
            ? const Center(child: Text('Offline...'))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('Server Failure...'))
                : statusRequest == StatusRequest.failure
                    ? const Center(child: Text('No Data...'))
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
        ? const Center(child: Text('Loading...'))
        : statusRequest == StatusRequest.offlineFailure
            ? const Center(child: Text('Offline...'))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('Server Failure...'))
                : widget;
  }
}
