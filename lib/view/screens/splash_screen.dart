// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:pet_connect/core/constant/color.dart';
// import 'package:pet_connect/core/constant/imageasset.dart';
// import 'package:pet_connect/core/constant/routes.dart';
// import 'package:pet_connect/core/services/services.dart';
// import 'package:pet_connect/view/screens/home_screen.dart';
// import 'package:pet_connect/view/screens/login_screen.dart';
//
// // class SplashScreen extends StatelessWidget {
// //   const SplashScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     MyServices myServices = Get.find();
// //     return AnimatedSplashScreen(
// //       //backgroundColor: AppColor.primaryColor,
// //       splashIconSize: 201,
// //       pageTransitionType: PageTransitionType.bottomToTop,
// //       splashTransition: SplashTransition.fadeTransition,
// //       splash:
// // /*
// // * Image.asset(
// //           AppImageAsset.testLogo,
// //           width: 400,
// //           height: 500,
// //         ),**/
// //           const CircleAvatar(
// //         radius: 100,
// //         backgroundImage: AssetImage(AppImageAsset.logo),
// //       ),
// //       nextScreen: Text(AppRoute.loginScreen),
// //
// //       // myServices.sharedPreferences.getString("isLogin") == "true"
// //       //     ? const HomeScreen()
// //       //     : const LoginScreen(),
// //
// //       //SplashScreen()
// //     );
// //   }
// // }
// //
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   SplashScreenState createState() => SplashScreenState();
// }
//
// class SplashScreenState extends State<SplashScreen> {
//   MyServices myServices = Get.find();
//   @override
//   void initState() {
//     super.initState();
//
//     // Simulate any asynchronous initialization if needed
//     Future.delayed(const Duration(seconds: 2), () {
//       myServices.sharedPreferences.getString("isLogin") == "true"
//           ? Get.offNamed(AppRoute.homeScreen)
//           : Get.offNamed(AppRoute.loginScreen);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircleAvatar(
//           radius: 100,
//           backgroundImage:
//               AssetImage(AppImageAsset.logo), // Replace with your image asset
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/view/screens/home_screen.dart';
import 'package:pet_connect/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  MyServices myServices = Get.find();
  @override
  void initState() {
    super.initState();

    // Simulate any asynchronous initialization if needed
    Future.delayed(const Duration(seconds: 2), () {
      final isLogin =
          myServices.sharedPreferences.getString("isLogin") == "true";
      if (isLogin) {
        Get.offNamed(AppRoute.homeScreen);
      } else {
        Get.offNamed(AppRoute.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage:
              AssetImage(AppImageAsset.logo), // Replace with your image asset
        ),
      ),
    );
  }
}
