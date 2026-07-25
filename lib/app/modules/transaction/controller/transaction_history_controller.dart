import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:smartfin_mobile_app/app/modules/transaction/model/transaction_model.dart';


class TransactionHistoryController extends GetxController {
  final dashboardController = Get.find<DashboardController>();

  final searchController = TextEditingController();

  final search = "".obs;
  final typeFilter = "all".obs; // all | income | expense

  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();

  RxBool get isLoadingTransaction =>
      dashboardController.isLoadingTransaction;

  String formatRupiah(num amount) {
    return dashboardController.formatRupiah(amount);
  }

  List<TransactionModel> get transactions {
    var data = dashboardController.transactions.toList();

    // Search
    if (search.value.isNotEmpty) {
      data = data.where((e) {
        return e.title
            .toLowerCase()
            .contains(search.value.toLowerCase());
      }).toList();
    }

    // Type
    if (typeFilter.value != "all") {
      data = data
          .where((e) => e.transactionType == typeFilter.value)
          .toList();
    }

    // Date
    if (startDate.value != null && endDate.value != null) {
      data = data.where((e) {
        return !e.transactionDate.isBefore(startDate.value!) &&
            !e.transactionDate.isAfter(endDate.value!);
      }).toList();
    }

    return data;
  }
}