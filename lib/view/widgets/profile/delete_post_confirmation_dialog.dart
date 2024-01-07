// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pet_connect/core/constant/color.dart';
//
// class DeletePostConfDialog extends StatelessWidget {
//
//   const DeletePostConfDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GetBuilder<HomeControllerImp>(
//         builder: (controller) {
//           return AlertDialog(
//             title: Text(
//               'تنبيه',
//               style: TextStyle(color: AppColor.primaryColor),
//             ),
//             content: Text(
//               'هل تريد حذف هذا الحيوان؟',
//               style: TextStyle(color: AppColor.black, fontSize: 20),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   'لا',
//                   style: TextStyle(
//                     color: AppColor.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Use the correct method to remove the post
//                   controller.removePost(index);
//                   Get.back();
//                 },
//                 child: Text(
//                   'نعم',
//                   style: TextStyle(
//                     color: AppColor.primaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
