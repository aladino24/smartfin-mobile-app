import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/custom_dialog.dart';
import '../../transaction/model/transaction_model.dart';

class DashboardController extends GetxController {
   final ApiService api = ApiService();
  final StorageService storage = StorageService();
  var isLoadingTransaction = false.obs;
  var transactions = <TransactionModel>[].obs;

  // =========================
  // USER STATE
  // =========================
  final user = Rxn<UserData>();
  final isLoadingUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
    getTransactions();
  }

  String formatRupiah(int amount) {
  return "Rp ${amount.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  )}";
}

  // =====================================================
  // GET USER (USING MODEL)
  // =====================================================
  Future<void> getUser() async {
    try {
      isLoadingUser.value = true;
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
        print("User Data: ${user.value!.fullName}");
      } else {
        throw Exception(model.message);
      }
    } catch (e) {
       CustomDialog.error(
        title: "Ambil Data User Gagal",
        message: e.toString(),
      );
    } finally {
      isLoadingUser.value = false;
    }
  }
  

  // =====================================================
  // REFRESH DASHBOARD
  // =====================================================
  Future<void> refreshDashboardData() async {
    await getUser();
    await getTransactions();
  }

  //transaction
  Future<void> getTransactions() async {
    try {
      isLoadingTransaction.value = true;

      final token = storage.getToken();

      if (token == null) {
        Get.offAllNamed('/login');
        return;
      }

      final res = await api.getTransactions(token);

      final model = TransactionResponse.fromJson(res);

      transactions.value = model.data.transactions;

    } catch (e) {
      CustomDialog.error(
        title: "Ambil Data Transaksi Gagal",
        message: e.toString(),
      );
    } finally {
      isLoadingTransaction.value = false;
    }
  }

  // =====================================================
  // GETTER HELPER (biar UI clean)
  // =====================================================
  String get fullName => user.value?.fullName ?? "-";
  String get email => user.value?.email ?? "-";
  String get phone => user.value?.phone ?? "-";
  String get avatar => user.value?.avatar ?? "";
}