import 'package:get/get.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/view/screens/create_post_screen.dart';
import 'package:pet_connect/view/screens/home_screen.dart';
import 'package:pet_connect/view/screens/signup_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/",
    page: () => const HomeScreen(),
    // middlewares: [
    //   MyMiddleWare(),
    // ],
  ),
  //AUTH
  GetPage(name: AppRoute.signupScreen, page: () => const SignupScreen()),
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(
      name: AppRoute.createPostScreen, page: () => const CreatePostScreen()),
];
