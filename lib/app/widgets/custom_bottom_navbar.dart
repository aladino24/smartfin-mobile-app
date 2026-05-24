import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smartfin_mobile_app/app/controllers/main_navigation_controller.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class CustomBottomNavbar extends StatelessWidget {
  CustomBottomNavbar({super.key});

  final controller =
      Get.find<MainNavigationController>();

  final List<String> menuTitles = [
    "Home",
    "Wallet",
    "AI",
    "Setting",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),

          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // =========================
                // WATER DROP NAVBAR
                // =========================

                WaterDropNavBar(
                  backgroundColor: Colors.white,

                  waterDropColor:
                      const Color(0xFFD4AF37),

                  inactiveIconColor:
                      Colors.grey.shade500,

                  selectedIndex:
                      controller.selectedIndex.value,

                  onItemSelected:
                      controller.changePage,

                  iconSize: 28,

                  bottomPadding: 6,

                  barItems: [

                    // =========================
                    // HOME
                    // =========================

                    BarItem(
                      filledIcon:
                          Icons.home_rounded,
                      outlinedIcon:
                          Icons.home_outlined,
                    ),

                    // =========================
                    // WALLET
                    // =========================

                    BarItem(
                      filledIcon:
                          Icons
                              .account_balance_wallet_rounded,
                      outlinedIcon:
                          Icons
                              .account_balance_wallet_outlined,
                    ),

                    // =========================
                    // AI (ROBOT ICON)
                    // =========================

                    BarItem(
                      filledIcon:
                          Icons.smart_toy_rounded,
                      outlinedIcon:
                          Icons.smart_toy_outlined,
                    ),

                    // =========================
                    // SETTING
                    // =========================

                    BarItem(
                      filledIcon:
                          Icons.settings_rounded,
                      outlinedIcon:
                          Icons.settings_outlined,
                    ),
                  ],
                ),

                // =========================
                // LABEL MENU
                // =========================

                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,

                    children: List.generate(
                      menuTitles.length,
                      (index) {
                        final isSelected =
                            controller
                                    .selectedIndex
                                    .value ==
                                index;

                        return Expanded(
                          child: Center(
                            child:
                                AnimatedDefaultTextStyle(
                              duration:
                                  const Duration(
                                milliseconds: 250,
                              ),

                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight:
                                    isSelected
                                        ? FontWeight
                                            .w700
                                        : FontWeight
                                            .w500,

                                color:
                                    isSelected
                                        ? const Color(
                                            0xFFD4AF37,
                                          )
                                        : Colors
                                            .grey
                                            .shade500,
                              ),

                              child: Text(
                                menuTitles[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}