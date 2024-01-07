import 'package:get/get.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/view/screens/add_new_pet.dart';
import 'package:pet_connect/view/screens/add_phone_screen.dart';
import 'package:pet_connect/view/screens/articles_screen.dart';
import 'package:pet_connect/view/screens/create_post_screen.dart';
import 'package:pet_connect/view/screens/forget_password/forget_password_screen.dart';
import 'package:pet_connect/view/screens/forget_password/success_reset_pass_screen.dart';
import 'package:pet_connect/view/screens/forget_password/verify_code_forget_screen.dart';
import 'package:pet_connect/view/screens/home_screen.dart';
import 'package:pet_connect/view/screens/login_screen.dart';
import 'package:pet_connect/view/screens/profile_screen.dart';
import 'package:pet_connect/view/screens/settings_screen.dart';
import 'package:pet_connect/view/screens/signup_screen.dart';
import 'package:pet_connect/view/screens/splash_screen.dart';
import 'package:pet_connect/view/screens/success_sign_up_screen.dart';
import 'package:pet_connect/view/screens/verify_code_sign_up_screen.dart';

import 'view/screens/forget_password/reset_password_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/",
    page: () => const SplashScreen(),
    // middlewares: [
    //   MyMiddleWare(),
    // ],
  ),
  //AUTH
  GetPage(name: AppRoute.signupScreen, page: () => const SignupScreen()),
  GetPage(name: AppRoute.loginScreen, page: () => const LoginScreen()),
  GetPage(
      name: AppRoute.forgetPasswordScreen,
      page: () => const ForgetPasswordScreen()),
  GetPage(
      name: AppRoute.verifyCodeForgetPassScreen,
      page: () => const VerifyCodeForgetPassScreen()),
  GetPage(
      name: AppRoute.verifyCodeSignUpScreen,
      page: () => const VerifyCodeSignUpScreen()),
  GetPage(
      name: AppRoute.resetPasswordScreen,
      page: () => const ResetPasswordScreen()),
  GetPage(
      name: AppRoute.successResetPasswordScreen,
      page: () => const SuccessResetPasswordScreen()),
  GetPage(
      name: AppRoute.successSignUpScreen,
      page: () => const SuccessSignUpScreen()),

  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(
    name: AppRoute.createPostScreen,
    page: () => const CreatePostScreen(),
  ),

  GetPage(name: AppRoute.profileScreen, page: () => const ProfileScreen()),
  GetPage(name: AppRoute.addNewPetScreen, page: () => const AddNewPet()),
  GetPage(name: AppRoute.articlesScreen, page: () => const ArticlesScreen()),
  GetPage(name: AppRoute.settingsScreen, page: () => const SettingsScreen()),
  GetPage(name: AppRoute.addPhoneScreen, page: () => const AddPhoneScreen()),
  //GetPage(name: AppRoute.dynamicViewScreen, page: () => const DynamicViewScreen(title: title, posts: posts)),
];
