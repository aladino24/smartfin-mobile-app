import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/custom_dialog.dart';
import '../../transaction/model/transaction_model.dart';
import '../models/dashboard_model.dart';

class DashboardController extends GetxController {
   final ApiService api = ApiService();
  final StorageService storage = StorageService();
  var isLoadingTransaction = false.obs;
  var transactions = <TransactionModel>[].obs;
  var isLoadingDashboard = false.obs;

final dashboard = Rxn<DashboardData>();

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
      getDashboard();
  }

 String formatRupiah(num amount) {
  final value = amount.toInt();

  return "Rp ${value.toString().replaceAllMapped(
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
    await getDashboard();
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

  Future<void> getDashboard() async {
  try {
    isLoadingDashboard.value = true;

    final token = storage.getToken();

    if (token == null) {
      Get.offAllNamed('/login');
      return;
    }

    final res = await api.getDashboard(token);

    final model = DashboardResponse.fromJson(res);

    dashboard.value = model.data;

  } catch (e) {
    CustomDialog.error(
      title: "Ambil Dashboard Gagal",
      message: e.toString(),
    );
  } finally {
    isLoadingDashboard.value = false;
  }
}

  // =====================================================
  // GETTER HELPER (biar UI clean)
  // =====================================================
  String get fullName => user.value?.fullName ?? "-";
  String get email => user.value?.email ?? "-";
  String get phone => user.value?.phone ?? "-";
  String get avatar => user.value?.avatar ?? "";

  //==================================================
  // OVERVIEW
  //==================================================

  double get totalBalance =>
      dashboard.value?.overview.totalBalance ?? 0;

  double get monthlyIncome =>
      dashboard.value?.overview.monthlyIncome ?? 0;

  double get monthlyExpense =>
      dashboard.value?.overview.monthlyExpense ?? 0;

  double get totalInvestment =>
      dashboard.value?.overview.totalInvestment ?? 0;

  int get financialScore =>
      dashboard.value?.overview.financialScore ?? 0;

  double get previousBalance =>
    dashboard.value?.overview.previousBalance ?? 0;

  double get balanceChangePercent =>
      dashboard.value?.overview.balanceChangePercent ?? 0;

  String get balanceChangeType =>
      dashboard.value?.overview.balanceChangeType ?? "stable";

  bool get isIncrease =>
      balanceChangeType == "increase";

  //==================================================
  // AI
  //==================================================

  String get aiInsight =>
      dashboard.value?.aiInsight ?? "";

  //==================================================
  // RECENT TRANSACTION
  //==================================================

  List<TransactionModel> get recentDashboardTransactions =>
      dashboard.value?.recentTransactions ?? [];

  //==================================================
  // CASHFLOW
  //==================================================

  List<CashflowChart> get cashflowChart =>
      dashboard.value?.cashflowChart ?? [];

  //==================================================
  // EXPENSE CATEGORY
  //==================================================

  List<ExpenseCategory> get expenseByCategory =>
      dashboard.value?.expenseByCategory ?? [];

  List<WalletModel> get walletSummary =>
    dashboard.value?.overview.walletSummary ?? [];

  //==================================================
  // FINANCIAL SCORE
  //==================================================

  double get financialProgress =>
      financialScore / 100;

  String get financialStatus {
    if (financialScore >= 90) {
      return "Excellent";
    }

    if (financialScore >= 75) {
      return "Good";
    }

    if (financialScore >= 60) {
      return "Fair";
    }

    if (financialScore >= 40) {
      return "Poor";
    }

    return "Critical";
  }
}