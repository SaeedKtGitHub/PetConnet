import 'package:get/get.dart';
import 'package:pet_connect/core/middleware/my_middleware.dart';
import 'package:pet_connect/view/screens/login_screen.dart';
import 'package:pet_connect/view/screens/signup_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const LoginScreen(), middlewares: [
    MyMiddleWare(),
  ]),
  //AUTH
  GetPage(name: AppRoute.signupScreen, page: () => const SignupScreen()),
  // GetPage(name: AppRoute.signUp, page: () => const SignUp()),
];
