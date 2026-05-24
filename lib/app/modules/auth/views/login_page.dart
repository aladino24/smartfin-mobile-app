import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/auth/views/theme_controller.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

    final ThemeController themeController =
      Get.find<ThemeController>();

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
                opacity: isDark ? 0.16 : 0.22,
                child: CustomPaint(
                  size: const Size(280, 280),
                  painter: AdvancedBatikFlowerPainter(
                    color: accentGold,
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
                opacity: isDark ? 0.12 : 0.18,
                child: Transform.rotate(
                  angle: math.pi,
                  child: CustomPaint(
                    size: const Size(280, 280),
                    painter: AdvancedBatikFlowerPainter(
                      color: accentGold,
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
            // TOGGLE THEME BUTTON
            // =========================

            Positioned(
              top: 55,
              right: 24,
              child: GestureDetector(
                onTap: themeController.toggleTheme,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isDark
                              ? Colors.white10
                              : Colors.black12,
                    ),
                  ),
                  child: Icon(
                    isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: accentGold,
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
                            Icons.account_balance_wallet_rounded,
                            size: 42,
                            color:
                                isDark
                                    ? primaryBg
                                    : const Color(0xFF1E293B),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "SmartFin",
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Financial Management Platform",
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 36),

                        // =========================
                        // EMAIL FIELD
                        // =========================

                        TextField(
                          onChanged: (v) =>
                              controller.email.value = v,
                          style: TextStyle(
                            color: textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: "Email atau Username",
                            hintStyle: TextStyle(
                              color:
                                  isDark
                                      ? Colors.white38
                                      : Colors.black38,
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: accentGold,
                            ),
                            filled: true,
                            fillColor:
                                isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.black.withOpacity(0.03),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color:
                                    isDark
                                        ? Colors.white.withOpacity(0.08)
                                        : Colors.black.withOpacity(0.05),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: accentGold,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =========================
                        // PASSWORD FIELD
                        // =========================

                        TextField(
                          obscureText:
                              controller.obscurePassword.value,
                          onChanged: (v) =>
                              controller.password.value = v,
                          style: TextStyle(
                            color: textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color:
                                  isDark
                                      ? Colors.white38
                                      : Colors.black38,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: accentGold,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:
                                    isDark
                                        ? Colors.white54
                                        : Colors.black45,
                              ),
                              onPressed:
                                  controller.togglePassword,
                            ),
                            filled: true,
                            fillColor:
                                isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.black.withOpacity(0.03),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color:
                                    isDark
                                        ? Colors.white.withOpacity(0.08)
                                        : Colors.black.withOpacity(0.05),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: accentGold,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // =========================
                        // LOGIN BUTTON
                        // =========================

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : controller.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentGold,
                              foregroundColor:
                                  const Color(0xFF08111F),
                              elevation: 10,
                              shadowColor:
                                  accentGold.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                            ),
                            child:
                                controller.isLoading.value
                                    ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child:
                                          CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Color(
                                              0xFF08111F,
                                            ),
                                          ),
                                    )
                                    : const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =========================
                        // FORGOT PASSWORD
                        // =========================

                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: textSecondary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        // =========================
                        // REGISTER
                        // =========================

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum memiliki akun?",
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
                                Get.toNamed('/register');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  color: accentGold.withOpacity(
                                    0.12,
                                  ),
                                ),
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    color: accentGold,
                                    fontWeight: FontWeight.bold,
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
          ],
        ),
      );
    });
  }
}

// ======================================================
// BATIK FLOWER PAINTER
// ======================================================

class AdvancedBatikFlowerPainter extends CustomPainter {
  final Color color;

  AdvancedBatikFlowerPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.95)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * math.pi / 180;

      final path = Path();

      path.moveTo(center.dx, center.dy);

      path.quadraticBezierTo(
        center.dx + 90 * math.cos(angle - 0.2),
        center.dy + 90 * math.sin(angle - 0.2),
        center.dx + 40 * math.cos(angle),
        center.dy + 40 * math.sin(angle),
      );

      path.quadraticBezierTo(
        center.dx + 90 * math.cos(angle + 0.2),
        center.dy + 90 * math.sin(angle + 0.2),
        center.dx,
        center.dy,
      );

      canvas.drawPath(path, paint);
    }

    canvas.drawCircle(
      center,
      18,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}