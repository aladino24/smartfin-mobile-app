import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    const Color primaryDark = Color(0xFF08111F);
    const Color accentGold = Color(0xFFD4AF37);
    const Color bgLight = Color(0xFFF8FAFC);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
          color: accentGold, // Warna spinner loader
          backgroundColor: primaryDark, // Warna background spinner
          strokeWidth: 2.5,
        onRefresh: () async {
          await controller.refreshData();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
        
            // ================= PROFILE =================
            _sectionTitle("Account"),
        
            _profileCard(),
        
            const SizedBox(height: 16),
        
            // ================= THEME =================
            _sectionTitle("Appearance"),
        
            Obx(() => SwitchListTile(
                  value: controller.isDarkMode.value,
                  onChanged: (val) => controller.toggleTheme(),
                  title: const Text("Dark Mode"),
                  secondary: const Icon(Icons.dark_mode_rounded),
                )),
        
            const SizedBox(height: 16),
        
            // ================= DATA =================
            _sectionTitle("Data"),
        
            _tile(
              icon: Icons.refresh_rounded,
              title: "Reset User Data",
              subtitle: "Hapus semua data user dan mulai dari awal",
              onTap: controller.resetUserData,
            ),
        
            _tile(
              icon: Icons.insert_drive_file_rounded,
              title: "Documents",
              subtitle: "File & dokumen aplikasi",
              onTap: () {
                Get.toNamed(
                  '/knowledge'
                );
              },
            ),
        
            _tile(
              icon: Icons.newspaper_rounded,
              title: "Latest Information",
              subtitle: "Update & news aplikasi",
              onTap: () {},
            ),
        
            const SizedBox(height: 16),
        
            // ================= ABOUT =================
            _sectionTitle("App"),
        
            _tile(
              icon: Icons.info_outline_rounded,
              title: "About App",
              subtitle: "SmartFin Financial App",
              onTap: () {
                Get.toNamed('/about');
              },
            ),
        
            _tile(
              icon: Icons.verified_rounded,
              title: "Version",
              subtitle: "v1.0.0",
              onTap: () {},
            ),
        
            const SizedBox(height: 24),
        
            // ================= LOGOUT =================
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: controller.logout,
              icon: const Icon(Icons.logout,color: Colors.white,),
              label: const Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGETS =================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _profileCard() {
  return Obx(
    () => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF1E2A44),
            backgroundImage:
                controller.avatar != null &&
                        controller.avatar.toString().trim().isNotEmpty
                    ? NetworkImage(controller.avatar!)
                    : null,
            child:
                controller.avatar == null ||
                        controller.avatar.toString().trim().isEmpty
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.fullName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Tap to update profile",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    ),
  );
}

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD4AF37)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}