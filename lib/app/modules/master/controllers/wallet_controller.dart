

import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../models/wallet_model.dart';


class WalletController extends GetxController {
  RxList<WalletModel> wallets =
    <WalletModel>[].obs;

  RxString selectedWallet =
      ''.obs;
   final StorageService storage = StorageService();
  final ApiService api = ApiService();

  Future<void> loadWallets() async {
      try {
        final token = storage.getToken();

        final result =
            await api.getWallets(
          token.toString(),
        );

        wallets.value = result;

        if (wallets.isNotEmpty) {
          selectedWallet.value =
              wallets.first.walletName;
        }
      } catch (e) {
        print(e);
      }
    }
}