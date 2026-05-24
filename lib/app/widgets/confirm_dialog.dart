import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog {
  static Future<bool> show({
    required String title,
    required String message,
    String confirmText = "Ya",
    String cancelText = "Batal",
    Color confirmColor = const Color(0xFFD4AF37),
  }) async {
    final result = await Get.dialog<bool>(
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // ICON
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: confirmColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: confirmColor,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 16),

                // TITLE
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // MESSAGE
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                // BUTTONS
                Row(
                  children: [

                    // CANCEL
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(result: false),
                        child: Text(cancelText),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // CONFIRM
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Get.back(result: true),
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    return result ?? false;
  }
}