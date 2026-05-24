import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void success({
    required String title,
    required String message,
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.check_circle_rounded,
      iconColor: const Color(0xFF22C55E),
      buttonColor: const Color(0xFFD4AF37),
    );
  }

  static void error({
    required String title,
    required String message,
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.cancel_rounded,
      iconColor: const Color(0xFFEF4444),
      buttonColor: const Color(0xFFEF4444),
    );
  }

  static void warning({
    required String title,
    required String message,
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: const Color(0xFFF59E0B),
      buttonColor: const Color(0xFFF59E0B),
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
    required Color buttonColor,
  }) {
    final isDark = Get.isDarkMode;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      const Color(0xFF0F172A),
                      const Color(0xFF111827),
                    ]
                  : [
                      Colors.white,
                      const Color(0xFFF8FAFC),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ICON
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 50,
                ),
              ),

              const SizedBox(height: 24),

              // TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? Colors.white
                      : const Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 12),

              // MESSAGE
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: isDark
                      ? Colors.white70
                      : Colors.black54,
                ),
              ),

              const SizedBox(height: 28),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}