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

  final box = GetStorage();

  // =========================
  // CHECK TOKEN
  // =========================

  final String? token = box.read('token');

  final bool isLoggedIn =
      token != null && token.isNotEmpty;

  runApp(
    MyApp(
      isLoggedIn: isLoggedIn,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(
      ThemeController(),
      permanent: true,
    );

    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      title: 'SmartFin',

      initialRoute:
          isLoggedIn
              ? AppRoutes.main
              : AppRoutes.login,

      getPages: AppPages.pages,
    );
  }
}