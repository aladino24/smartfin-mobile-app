import 'package:get/get.dart';

class RegisterController extends GetxController {
  final fullName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final password = ''.obs;

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> register() async {
    try {
      isLoading.value = true;

      final body = {
        "full_name": fullName.value,
        "email": email.value,
        "phone": phone.value,
        "password": password.value,
      };

      print(body);

      await Future.delayed(
        const Duration(seconds: 2),
      );

      Get.snackbar(
        "Success",
        "Register success",
      );
    } finally {
      isLoading.value = false;
    }
  }
}