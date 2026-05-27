import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../master/models/wallet_model.dart';

class WalletModuleController extends GetxController {
  final wallets = <WalletModel>[].obs;
  final filteredWallets = <WalletModel>[].obs;

  final isLoading = false.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    loadWallets();

    searchController.addListener(() {
      filterWallets();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadWallets() async {
    try {
      isLoading.value = true;

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      wallets.assignAll([
        WalletModel(
          id: 1,
          uuid: "wallet-bca",
          userId: 1,
          walletName: "BCA",
          walletType: "bank",
          balance: 11125000,
          currency: "IDR",
          icon: "account_balance",
          color: "#2563EB",
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),

        WalletModel(
          id: 2,
          uuid: "wallet-cash",
          userId: 1,
          walletName: "Cash",
          walletType: "cash",
          balance: 2500000,
          currency: "IDR",
          icon: "payments",
          color: "#22C55E",
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),

        WalletModel(
          id: 3,
          uuid: "wallet-ovo",
          userId: 1,
          walletName: "OVO",
          walletType: "ewallet",
          balance: 750000,
          currency: "IDR",
          icon: "account_balance_wallet",
          color: "#7C3AED",
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),

        WalletModel(
          id: 4,
          uuid: "wallet-dana",
          userId: 1,
          walletName: "DANA",
          walletType: "ewallet",
          balance: 1200000,
          currency: "IDR",
          icon: "account_balance_wallet",
          color: "#06B6D4",
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),

        WalletModel(
          id: 5,
          uuid: "wallet-bitcoin",
          userId: 1,
          walletName: "Bitcoin Wallet",
          walletType: "crypto",
          balance: 3500000,
          currency: "IDR",
          icon: "currency_bitcoin",
          color: "#F59E0B",
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ]);

      filteredWallets.assignAll(wallets);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshWallets() async {
    await loadWallets();
  }

  void filterWallets() {
    final keyword = searchController.text.toLowerCase();

    if (keyword.isEmpty) {
      filteredWallets.assignAll(wallets);
      return;
    }

    filteredWallets.assignAll(
      wallets.where(
        (wallet) =>
            wallet.walletName.toLowerCase().contains(keyword) ||
            wallet.walletType.toLowerCase().contains(keyword),
      ),
    );
  }

  // ==========================
  // STATISTIC
  // ==========================

  double get totalBalance {
    return wallets.fold(
      0.0,
      (sum, item) => sum + item.balance.toDouble(),
    );
  }

  int get walletCount => wallets.length;

  int get bankCount {
    return wallets.where((e) => e.walletType == "bank").length;
  }

  int get ewalletCount {
    return wallets.where((e) => e.walletType == "ewallet").length;
  }

  int get cryptoCount {
    return wallets.where((e) => e.walletType == "crypto").length;
  }

  int get cashCount {
    return wallets.where((e) => e.walletType == "cash").length;
  }

  // ==========================
  // ICON
  // ==========================

  IconData getWalletIcon(String type) {
    switch (type.toLowerCase()) {
      case "bank":
        return Icons.account_balance_rounded;

      case "cash":
        return Icons.payments_rounded;

      case "crypto":
        return Icons.currency_bitcoin_rounded;

      case "ewallet":
        return Icons.account_balance_wallet_rounded;

      default:
        return Icons.wallet_rounded;
    }
  }

  // ==========================
  // COLOR
  // ==========================

  Color getWalletColor(String colorHex) {
    try {
      return Color(
        int.parse(
          colorHex.replaceAll("#", "0xFF"),
        ),
      );
    } catch (_) {
      return Colors.blue;
    }
  }
}