import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/auth/controllers/register_controller.dart';
import 'package:smartfin_mobile_app/app/modules/auth/views/login_page.dart';
import 'package:smartfin_mobile_app/app/modules/auth/views/theme_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({super.key});

    final ThemeController themeController =
        Get.find<ThemeController>();
    final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      // =========================
      // THEME COLORS
      // =========================

      final Color primaryBg =
          isDark ? const Color(0xFF08111F) : const Color(0xFFF4F7FC);

      final Color secondaryBg =
          isDark ? const Color(0xFF0F1C2E) : const Color(0xFFE7EEF8);

      final Color glowColor =
          isDark ? const Color(0xFF132238) : const Color(0xFFD9E7FF);

      const Color accentGold = Color(0xFFD4AF37);

      final Color textPrimary =
          isDark ? Colors.white : const Color(0xFF1E293B);

      final Color textSecondary =
          isDark ? Colors.white60 : Colors.black54;

      final Color cardColor =
          isDark
              ? Colors.white.withOpacity(0.06)
              : Colors.white.withOpacity(0.78);

      return Scaffold(
        backgroundColor: primaryBg,
        body: Stack(
          children: [
            // =========================
            // BACKGROUND GRADIENT
            // =========================

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryBg,
                    secondaryBg,
                    glowColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // =========================
            // BATIK TOP RIGHT
            // =========================

            Positioned(
              top: -40,
              right: -40,
              child: Opacity(
                opacity: isDark ? 0.16 : 0.24,
                child: CustomPaint(
                  size: const Size(280, 280),
                  painter: AdvancedBatikFlowerPainter(
                    color:
                        isDark
                            ? accentGold
                            : const Color(0xFFC3921B),
                  ),
                ),
              ),
            ),

            // =========================
            // BATIK BOTTOM LEFT
            // =========================

            Positioned(
              bottom: -50,
              left: -50,
              child: Opacity(
                opacity: isDark ? 0.12 : 0.20,
                child: Transform.rotate(
                  angle: math.pi,
                  child: CustomPaint(
                    size: const Size(280, 280),
                    painter: AdvancedBatikFlowerPainter(
                      color:
                          isDark
                              ? accentGold
                              : const Color(0xFFC3921B),
                    ),
                  ),
                ),
              ),
            ),

            // =========================
            // GLOW EFFECTS
            // =========================

            Positioned(
              top: 90,
              left: -70,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: glowColor.withOpacity(
                    isDark ? 0.28 : 0.5,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 100,
              right: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentGold.withOpacity(
                    isDark ? 0.10 : 0.06,
                  ),
                ),
              ),
            ),

            // =========================
            // CONTENT
            // =========================

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color:
                            isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.05),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDark
                                  ? Colors.black.withOpacity(0.25)
                                  : Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // =========================
                          // LOGO
                          // =========================
                      
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  accentGold,
                                  Color(0xFFF4E2A1),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accentGold.withOpacity(0.35),
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_add_alt_1_rounded,
                              size: 42,
                              color:
                                  isDark
                                      ? primaryBg
                                      : const Color(0xFF1E293B),
                            ),
                          ),
                      
                          const SizedBox(height: 24),
                      
                          Text(
                            "Create Account",
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                      
                          const SizedBox(height: 8),
                      
                          Text(
                            "Join SmartFin Financial Platform",
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 14,
                            ),
                          ),
                      
                          const SizedBox(height: 34),
                      
                          // =========================
                          // FULL NAME
                          // =========================
                      
                          buildInput(
                            hint: "Full Name",
                            icon: Icons.person_outline,
                            textPrimary: textPrimary,
                            isDark: isDark,
                            onChanged: (v) =>
                                controller.fullName.value = v,
                          ),
                      
                          const SizedBox(height: 18),
                      
                          // =========================
                          // EMAIL
                          // =========================
                      
                          buildInput(
                            hint: "Email atau Username",
                            icon: Icons.email_outlined,
                            textPrimary: textPrimary,
                            isDark: isDark,
                            keyboardType:
                                TextInputType.emailAddress,
                            onChanged: (v) =>
                                controller.email.value = v,
                          ),
                      
                          const SizedBox(height: 18),
                      
                          // =========================
                          // PHONE
                          // =========================
                      
                          buildInput(
                            hint: "Phone Number",
                            icon: Icons.phone_outlined,
                            textPrimary: textPrimary,
                            isDark: isDark,
                            keyboardType: TextInputType.phone,
                            onChanged: (v) =>
                                controller.phone.value = v,
                          ),
                      
                          const SizedBox(height: 18),
                      
                          // =========================
                          // PASSWORD
                          // =========================
                      
                          Obx(
                              () => TextFormField(
                                obscureText: controller.obscurePassword.value,
                                onChanged: (v) => controller.password.value = v,
                                style: TextStyle(
                                  color: textPrimary,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password wajib diisi";
                                  }

                                  if (value.length < 6) {
                                    return "Password minimal 6 karakter";
                                  }

                                  return null;
                                },
                                decoration: inputDecoration(
                                  hint: "Password",
                                  icon: Icons.lock_outline,
                                  isDark: isDark,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black45,
                                    ),
                                    onPressed: controller.togglePassword,
                                  ),
                                ),
                              ),
                            ),
                      
                          const SizedBox(height: 32),
                      
                          // =========================
                          // REGISTER BUTTON
                          // =========================
                      
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed:
                                    controller
                                            .isLoading
                                            .value
                                        ? null
                                        : () {
                                  if (formKey.currentState!.validate()) {
                                    controller.register();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      accentGold,
                                  foregroundColor:
                                      const Color(0xFF08111F),
                                  elevation: 10,
                                  shadowColor: accentGold
                                      .withOpacity(0.5),
                                  shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                              16,
                                            ),
                                      ),
                                ),
                                child:
                                    controller.isLoading.value
                                        ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child:
                                              CircularProgressIndicator(
                                                strokeWidth:
                                                    2.5,
                                                color: Color(
                                                  0xFF08111F,
                                                ),
                                              ),
                                        )
                                        : const Text(
                                          "REGISTER",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing:
                                                1,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                      
                          const SizedBox(height: 22),
                      
                          // =========================
                          // LOGIN CTA
                          // =========================
                      
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sudah memiliki akun?",
                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                      
                              const SizedBox(width: 6),
                      
                              InkWell(
                                borderRadius:
                                    BorderRadius.circular(10),
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(
                                          10,
                                        ),
                                    color: accentGold
                                        .withOpacity(0.12),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: accentGold,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // =========================
            // TOGGLE THEME
            // =========================

            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    right: 20,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      onTap: themeController.toggleTheme,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            padding: const EdgeInsets.all(
                              12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? Colors.white
                                          .withOpacity(0.08)
                                      : Colors.white
                                          .withOpacity(0.75),
                              borderRadius:
                                  BorderRadius.circular(
                                    16,
                                  ),
                              border: Border.all(
                                color:
                                    isDark
                                        ? Colors.white10
                                        : Colors.black12,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(
                                        isDark
                                            ? 0.18
                                            : 0.06,
                                      ),
                                  blurRadius: 12,
                                  offset:
                                      const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: accentGold,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildInput({
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
    required bool isDark,
    required Color textPrimary,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
        color: textPrimary,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Field ini tidak boleh kosong";
        }
        return null;
      },
      decoration: inputDecoration(
        hint: hint,
        icon: icon,
        isDark: isDark,
      ),
    );
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    required bool isDark,
    Widget? suffixIcon,
  }) {
    const Color accentGold = Color(0xFFD4AF37);

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color:
            isDark
                ? Colors.white38
                : Colors.black38,
      ),
      prefixIcon: Icon(
        icon,
        color: accentGold,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor:
          isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.03),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color:
              isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.05),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: accentGold,
          width: 1.5,
        ),
      ),
    );
  }
}