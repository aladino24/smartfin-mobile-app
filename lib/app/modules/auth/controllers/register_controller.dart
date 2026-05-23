import 'package:get/get.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_dialog.dart';

class RegisterController extends GetxController {
  final fullName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final password = ''.obs;

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  final ApiService api = ApiService();

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> register() async {
    try {
      isLoading.value = true;

      final data = await api.register(
        fullName.value.trim(),
        email.value.trim(),
        phone.value.trim(),
        password.value.trim(),
      );

      // tampilkan dialog success
      CustomDialog.success(
        title: "Register Success",
        message:
            data["message"] ??
            "Registration successful",
      );

      // clear form
      fullName.value = '';
      email.value = '';
      phone.value = '';
      password.value = '';

      // tunggu 2 detik
      await Future.delayed(
        const Duration(seconds: 2),
      );

      // tutup dialog jika masih terbuka
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // redirect ke login
      Get.offAllNamed('/login');
    } catch (e) {
      CustomDialog.error(
        title: "Register Failed",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}