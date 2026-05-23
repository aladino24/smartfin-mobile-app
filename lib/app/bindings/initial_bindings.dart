import 'package:get/get.dart';

import '../modules/master/controllers/wallet_controller.dart';
import '../modules/master/controllers/category_controller.dart';
import '../modules/transaction/controller/income_transaction_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<IncomeTransactionController>(
        () => IncomeTransactionController());
  }
}