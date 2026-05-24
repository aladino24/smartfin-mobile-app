
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/setting/views/about_page.dart';
import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/bindings/register_binding.dart';
import '../modules/auth/views/login_page.dart';
import '../modules/auth/views/register_page.dart';
import '../modules/dashboard/views/dashboard_page.dart';
import '../modules/main/views/main_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
    ),

    GetPage(
      name: AppRoutes.about,
      page: () => AboutPage(),
    ),
  ];
}