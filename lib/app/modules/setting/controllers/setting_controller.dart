import 'package:get/get.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/confirm_dialog.dart';

class SettingsController extends GetxController {
  final StorageService storage = StorageService();
  final ApiService api = ApiService();

  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  Future<void> logout() async {
    final confirm = await ConfirmDialog.show(
      title: "Logout",
      message: "Apakah kamu yakin ingin keluar dari aplikasi?",
      confirmText: "Logout",
    );

    if (!confirm) return;

    try {
      // optional: hit API logout
      final token = storage.getToken();
      if (token != null) {
        await api.logout(token); // kalau kamu punya endpoint logout
      }

      // clear local storage
      await storage.clearAll();

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Error", "Logout gagal: $e");
    }
  }

  void resetUserData() {
    Get.snackbar("Reset", "Data user berhasil direset");
  }
}