import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartfin_mobile_app/app/bindings/initial_bindings.dart';

import 'app/config/http_override.dart';
import 'app/modules/auth/views/theme_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      ThemeController(),
      permanent: true,
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartFin',
      initialBinding: InitialBinding(),

      /// Selalu buka Splash terlebih dahulu
      initialRoute: AppRoutes.splash,

      getPages: AppPages.pages,
    );
  }
}