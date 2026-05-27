import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/custom_dialog.dart';

class SettingsController extends GetxController {
  final StorageService storage = StorageService();
  final ApiService api = ApiService();
   final isLoadingUserSet = false.obs;

  var isDarkMode = false.obs;

  // USER STATE
  final user = Rxn<UserData>();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

   Future<void> refreshData() async {
    await getUser();
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

   Future<void> getUser() async {
    try {
      isLoadingUserSet.value = true;
      final token = storage.getToken();

      if (token == null) {
        throw Exception("Token tidak ditemukan");
      }

      final response = await http.get(
        Uri.parse("${api.baseUrl}/me"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final decoded = jsonDecode(response.body);

      final model = UserModel.fromJson(decoded);
      final dataUser = UserData.fromJson(decoded['data']);

      if (response.statusCode == 200 && model.success) {
        user.value = dataUser;
        print("User Data setting: ${user.value!.fullName}");
      } else {
        throw Exception(model.message);
      }
    } catch (e) {
       CustomDialog.error(
        title: "Ambil Data User Gagal",
        message: e.toString(),
      );
    } finally {
      isLoadingUserSet.value = false;
    }
  }

  String get fullName => user.value?.fullName ?? "-";
  String get email => user.value?.email ?? "-";
  String get phone => user.value?.phone ?? "-";
  String get avatar => user.value?.avatar ?? "";
}