import 'package:get/get.dart';
import 'package:pet_connect/core/middleware/my_middleware.dart';
import 'package:pet_connect/view/screens/login_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const LoginScreen(), middlewares: [
    MyMiddleWare(),
  ]),
  //AUTH
  // GetPage(name: AppRoute.login, page: () => const Login()),
  // GetPage(name: AppRoute.signUp, page: () => const SignUp()),
];
