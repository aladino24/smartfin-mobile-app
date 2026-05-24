import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/loading_helper.dart';

class LoginController extends GetxController {
  final ApiService api = ApiService();
  final StorageService storage = StorageService();

  final email = ''.obs;
  final password = ''.obs;

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      CustomDialog.warning(
        title: "Validasi",
        message: "Email dan password wajib diisi",
      );
      return;
    }

    try {
      isLoading.value = true;

      // =========================
      // SHOW LOADING
      // =========================

      LoadingHelper.show(
        text: "Authenticating...",
      );

      final res = await api.login(
        email.value,
        password.value,
      );

      // =========================
      // HIDE LOADING
      // =========================

      LoadingHelper.hide();

     final token = res['data']['token'];

      storage.saveToken(token);

      // =========================
      // NAVIGATION
      // =========================

      Get.offAllNamed('/main');

    } catch (e) {

      // =========================
      // HIDE LOADING
      // =========================

      LoadingHelper.hide();

      // =========================
      // ERROR DIALOG
      // =========================

      CustomDialog.error(
        title: "Login Gagal",
        message: e.toString(),
      );

    } finally {
      isLoading.value = false;
    }
  }
}