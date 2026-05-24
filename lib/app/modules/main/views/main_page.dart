import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/dashboard/views/dashboard_page.dart';

import '../../../controllers/main_navigation_controller.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../../setting/views/setting_page.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});

  final controller = Get.put(
    MainNavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // =========================
      // BODY PAGE
      // =========================

      body: PageView(
        controller: controller.pageController,

        physics:
            const NeverScrollableScrollPhysics(),

        children: [

          // =========================
          // HOME PAGE
          // =========================

          DashboardPage(),

          // =========================
          // WALLET PAGE
          // =========================

          WalletPage(),

          // =========================
          // AI PAGE
          // =========================

          AIPage(),

          // =========================
          // SETTING PAGE
          // =========================

          SettingsPage(),
        ],
      ),

      // =========================
      // BOTTOM NAVBAR
      // =========================

      bottomNavigationBar:
          CustomBottomNavbar(),
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home Page",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =====================================================
// WALLET PAGE
// =====================================================

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Wallet Page",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =====================================================
// AI PAGE
// =====================================================

class AIPage extends StatelessWidget {
  const AIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "AI Smart Assistant",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// =====================================================
// SETTING PAGE
// =====================================================

// class SettingPage extends StatelessWidget {
//   const SettingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Setting Page",
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }