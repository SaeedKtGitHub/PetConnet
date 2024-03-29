import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_connect/bindings/initial_bindings.dart';
import 'package:pet_connect/core/localization/changelocal.dart';
import 'package:pet_connect/core/localization/translation.dart';
import 'package:pet_connect/core/services/services.dart';
import 'package:pet_connect/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          translations: MyTranslation(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          locale: controller.language,
          // theme: controller.appTheme,
          initialBinding: InitialBindings(),
          // routes: routes,
          getPages: routes,
        );
      },
    );
  }
}
