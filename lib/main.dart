import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_connect/bindings/initial_bindings.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: const Locale('ar'),
      // theme: controller.appTheme,
      initialBinding: InitialBindings(),
      //routes: routes,
      getPages: routes,
    );
  }
}
