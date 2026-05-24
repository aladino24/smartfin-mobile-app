import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {

  final selectedIndex = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();
  }

  void changePage(int index) {
    selectedIndex.value = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}