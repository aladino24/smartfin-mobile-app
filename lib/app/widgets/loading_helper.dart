import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_loading.dart';

class LoadingHelper {
  static void show({
    String text = "Loading...",
    bool barrierDismissible = false,
  }) {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      Material(
        color: Colors.black38,
        child: CustomLoading(
          size: 90,
          text: text,
          useContainer: true,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}