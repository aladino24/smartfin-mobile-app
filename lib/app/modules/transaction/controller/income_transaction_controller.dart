import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/loading_helper.dart';
import '../../master/controllers/category_controller.dart';
import '../../master/controllers/wallet_controller.dart';

class IncomeTransactionController
    extends GetxController {
  final WalletController walletController = Get.put<WalletController>(WalletController());
  final CategoryController categoryController = Get.put<CategoryController>(CategoryController());
  // =========================
  // SPEECH
  // =========================

  final stt.SpeechToText speech =
      stt.SpeechToText();
  
  final ApiService api = ApiService();
  
  RxBool isListening = false.obs;

  RxString speechText = "".obs;

  // =========================
  // FORM
  // =========================

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final amountController =
      TextEditingController();

  RxString selectedWallet = "".obs;

  RxString selectedCategory =
      "".obs;

  Rx<DateTime> selectedDate =
      DateTime.now().obs;
  
   final StorageService storage = StorageService();

  // =========================
  // DUMMY DATA
  // =========================

  // oninit
    @override
  void onInit() {
    super.onInit();
    walletController.loadWallets();
    categoryController.loadCategory('income');
  }
  

  

  // =========================
  // PERMISSION
  // =========================

  Future<bool> requestMicPermission() async {
    final status =
        await Permission.microphone.request();

    return status.isGranted;
  }

  // =========================
  // START LISTEN
  // =========================

  Future<void> startListening() async {
    bool available =
        await speech.initialize();

    if (available) {
      isListening.value = true;

      speech.listen(
        localeId: "id_ID",
        onResult: (result) async {
          speechText.value =
              result.recognizedWords;

          // hanya proses saat final result
          if (result.finalResult) {
            await processVoiceText(
              speechText.value,
            );
          }
        },
      );
    }
  }

  // =========================
  // STOP LISTEN
  // =========================

  Future<void> stopListening() async {
    await speech.stop();

    isListening.value = false;
  }

  // =========================
  // PARSE VOICE
  // =========================

  void parseVoiceToForm(String text) {
    final lower = text.toLowerCase();

    // =========================
    // WALLET DETECT
    // =========================

    for (var wallet in walletController.wallets) {
      if (lower.contains(
        wallet.walletName.toLowerCase(),
      )) {
        selectedWallet.value = wallet.walletName;
      }
    }

    // =========================
    // CATEGORY DETECT
    // =========================

    for (var category in categoryController.categories) {
      if (lower.contains(
        category.categoryName.toLowerCase(),
      )) {
        selectedCategory.value =
            category.categoryName;
      }
    }

    // =========================
    // AMOUNT DETECT
    // =========================

    final amountRegex =
        RegExp(r'(\d+)');

    final amountMatch =
        amountRegex.firstMatch(lower);

    if (amountMatch != null) {
      amountController.text =
          amountMatch.group(0)!;
    }

    // =========================
    // TITLE AUTO
    // =========================


    // =========================
    // DESCRIPTION AUTO
    // =========================

    descriptionController.text =
        "Input otomatis dari SmartFin AI Voice";
  }

  void resetForm() {
    // clear text input
    titleController.clear();
    descriptionController.clear();
    amountController.clear();

    // reset speech text
    speechText.value = "";

    // reset dropdown
    selectedWallet.value = walletController.wallets.first.walletName;
    selectedCategory.value = categoryController.categories.first.categoryName;

    // reset date
    selectedDate.value = DateTime.now();

    // stop listening jika masih aktif
    if (isListening.value) {
      stopListening();
    }

    Get.snackbar(
      "Reset Success",
      "Voice & form berhasil direset",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: const Color(0xFFD4AF37),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      icon: const Icon(
        Icons.refresh_rounded,
        color: Color(0xFFD4AF37),
      ),
    );
  }

 Future<void> processVoiceText(
  String text,
) async {
  try {
    final token = storage.getToken();


    if (token == null || token.isEmpty) {
      await api.logout(
        token.toString()
      );

        Get.offAllNamed('/login');
      return;
    }

    LoadingHelper.show(
      text: "AI sedang memproses voice...",
    );

    final response = await api.parseVoice(
      text,
      token,
      'income',
    );

    final data = response.data;

    // =========================
    // AUTO FILL FORM
    // =========================

    print("Voice Transaction Data: ${data.toJson()}");

    titleController.text =
        data.title;

    descriptionController.text =
        data.description;

    amountController.text =
        data.amount.toString();

    selectedWallet.value =
        data.wallet;

    selectedCategory.value =
        data.category;

    update();

    LoadingHelper.hide();

    Get.snackbar(
      "Success",
      "Voice detected successfully",
      snackPosition:
          SnackPosition.TOP,
      backgroundColor:
          Colors.green,
      colorText: Colors.white,
    );
  } catch (e) {
    LoadingHelper.hide();

    print(e);

    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition:
          SnackPosition.TOP,
      backgroundColor:
          Colors.red,
      colorText: Colors.white,
    );
  }
}

  // =========================
  // SAVE
  // =========================

  Future<void> saveTransaction() async {
    try {
      if (titleController.text.isEmpty ||
          amountController.text.isEmpty) {
        CustomDialog.error(
          title: "Validation Error",
          message: "Title and Amount are required",
        );
        return;
      }

      if (selectedWallet.value.isEmpty ||
          selectedCategory.value.isEmpty) {
        CustomDialog.error(
          title: "Validation Error",
          message: "Please select wallet and category",
        );
        return;
      }

      final wallet = walletController.wallets.firstWhere(
          (w) => w.walletName == selectedWallet.value,
          orElse: () => walletController.wallets.first
        );

      final category = categoryController.categories.firstWhere(
          (c) => c.categoryName == selectedCategory.value,
          orElse: () => categoryController.categories.first
        );

   
      final body = {
        "wallet_id": wallet.id,
        "category_id": category.id,
        "transaction_type": "income",
        "title": titleController.text,
        "description": descriptionController.text,
        "amount": int.tryParse(amountController.text) ?? 0,
        "transaction_date": DateFormat('yyyy-MM-dd').format(selectedDate.value),
      };

      LoadingHelper.show(text: "Saving transaction...");

      final token = storage.getToken();

      final response = await api.createTransaction(
        body,
        token,
      );

      LoadingHelper.hide();

      if (response.success == true) {
        CustomDialog.success(
          title: "Success",
          message: "Transaction saved successfully",
        );

        // optional reset
        resetForm();
      } else {
        CustomDialog.error(
          title: "Save Failed",
          message: response.message ?? "Failed to save transaction",
        );
      }
    } catch (e) {
      LoadingHelper.hide();
      CustomDialog.error(
        title: "Save Failed",
        message: e.toString(),
      );
    }
  }
}