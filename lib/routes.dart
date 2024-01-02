import 'package:get/get.dart';
import 'package:pet_connect/core/constant/routes.dart';
import 'package:pet_connect/view/screens/add_new_pet.dart';
import 'package:pet_connect/view/screens/articles_screen.dart';
import 'package:pet_connect/view/screens/create_post_screen.dart';
import 'package:pet_connect/view/screens/home_screen.dart';
import 'package:pet_connect/view/screens/login_screen.dart';
import 'package:pet_connect/view/screens/profile_screen.dart';
import 'package:pet_connect/view/screens/settings_screen.dart';
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
    name: AppRoute.createPostScreen,
    page: () => const CreatePostScreen(),
  ),

  GetPage(name: AppRoute.profileScreen, page: () => const ProfileScreen()),
  GetPage(name: AppRoute.addNewPetScreen, page: () => const AddNewPet()),
  GetPage(name: AppRoute.articlesScreen, page: () => const ArticlesScreen()),
  GetPage(name: AppRoute.settingsScreen, page: () => const SettingsScreen()),
  //GetPage(name: AppRoute.dynamicViewScreen, page: () => const DynamicViewScreen(title: title, posts: posts)),
];
