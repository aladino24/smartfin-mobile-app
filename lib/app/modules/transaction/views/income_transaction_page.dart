import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/confirm_dialog.dart';
import '../controller/income_transaction_controller.dart';

class IncomeTransactionPage extends StatelessWidget {
  IncomeTransactionPage({super.key});

  final controller = Get.put(IncomeTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD4AF37), Color(0xFFB8932F)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  // BACK BUTTON
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // TITLE
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Income Transaction",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "SmartFin AI Voice Assistant",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // AI ICON
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // ====================================
              // HEADER
              // ====================================
              const SizedBox(height: 28),

              // ====================================
              // PREMIUM VOICE CARD
              // ====================================
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFD8B34B), Color(0xFFC89A1E)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD8B34B).withOpacity(.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //================================
                      // HEADER
                      //================================
                      Row(
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.mic_rounded,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Voice Assistant",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 3),

                                Text(
                                  "Tambah pemasukan menggunakan suara",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.18),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              controller.isListening.value
                                  ? "Listening"
                                  : "Ready",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      //================================
                      // MIC BUTTON
                      //================================
                      Center(
                        child: GestureDetector(
                          onLongPressStart: (_) async {
                            final allowed = await controller
                                .requestMicPermission();

                            if (!allowed) {
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  title: const Text("Microphone Permission"),
                                  content: const Text(
                                    "SmartFin membutuhkan akses microphone untuk menggunakan AI Voice Assistant.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );

                              return;
                            }

                            controller.startListening();
                          },

                          onLongPressEnd: (_) {
                            controller.stopListening();
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),

                            width: controller.isListening.value ? 88 : 74,

                            height: controller.isListening.value ? 88 : 74,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: controller.isListening.value
                                    ? [Colors.redAccent, Colors.red]
                                    : [Colors.white, const Color(0xFFF8F8F8)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.isListening.value
                                      ? Colors.red.withOpacity(.35)
                                      : Colors.white.withOpacity(.45),
                                  blurRadius: 18,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),

                            child: Icon(
                              controller.isListening.value
                                  ? Icons.graphic_eq_rounded
                                  : Icons.mic_rounded,
                              color: controller.isListening.value
                                  ? Colors.white
                                  : const Color(0xFFC89A1E),
                              size: 34,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      //================================
                      // STATUS
                      //================================
                      //==============================
                      // STATUS
                      //==============================
                      Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Container(
                            key: ValueKey(controller.isListening.value),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  controller.isListening.value
                                      ? Icons.graphic_eq_rounded
                                      : Icons.touch_app_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  controller.isListening.value
                                      ? "AI sedang mendengarkan..."
                                      : "Tekan & tahan untuk berbicara",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      //================================
                      // RESULT
                      //================================
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Container(
                          key: ValueKey(controller.speechText.value),
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.16),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.white,
                                    size: 18,
                                  ),

                                  SizedBox(width: 6),

                                  Text(
                                    "Contoh",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              Text(
                                controller.speechText.value.isEmpty
                                    ? "Gaji bulan ini 6 juta masuk ke BCA"
                                    : controller.speechText.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // ====================================
              // FORM CARD
              // ====================================
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),

                      blurRadius: 18,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    _modernInputCard(
                      title: "Income Title",
                      hint: "Contoh: Gaji Bulanan",
                      icon: Icons.edit_note_rounded,
                      controller: controller.titleController,
                    ),

                    const SizedBox(height: 16),

                    _modernInputCard(
                      title: "Description",
                      hint: "Tambahkan deskripsi income",
                      icon: Icons.notes_rounded,
                      controller: controller.descriptionController,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),

                    // ====================================
                    // 2 COLUMN
                    // ====================================
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => _modernSelector(
                              title: "Wallet",
                              icon: Icons.account_balance_wallet_rounded,

                              value:
                                  controller.walletController.wallets
                                      .map((w) => w.walletName)
                                      .contains(controller.selectedWallet.value)
                                  ? controller.selectedWallet.value
                                  : null,

                              items: controller.walletController.wallets
                                  .map((w) => w.walletName)
                                  .toList(),

                              onChanged: (v) {
                                controller.selectedWallet.value = v ?? '';
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Obx(() {
                            final items = controller
                                .categoryController
                                .categories
                                .map((c) => c.categoryName)
                                .toList();

                            return _modernSelector(
                              title: "Category",
                              icon: Icons.category_rounded,

                              value:
                                  items.contains(
                                    controller.selectedCategory.value,
                                  )
                                  ? controller.selectedCategory.value
                                  : null,

                              items: items,

                              onChanged: (v) {
                                controller.selectedCategory.value = v ?? '';
                              },
                            );
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ====================================
                    // AMOUNT
                    // ====================================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFD4AF37).withOpacity(0.08),
                            Colors.white,
                          ],
                        ),

                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Amount",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          TextField(
                            controller: controller.amountController,

                            keyboardType: TextInputType.number,

                            onChanged: (value) {
                              value = value.replaceAll(".", "");

                              if (value.isEmpty) return;

                              final number = int.tryParse(value);

                              if (number == null) return;

                              final formatted = NumberFormat.decimalPattern(
                                'id',
                              ).format(number);

                              controller.amountController.value =
                                  TextEditingValue(
                                    text: formatted,
                                    selection: TextSelection.collapsed(
                                      offset: formatted.length,
                                    ),
                                  );
                            },

                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),

                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixText: "Rp ",
                              prefixStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD4AF37),
                              ),
                              hintText: "0",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ====================================
                    // DATE
                    // ====================================
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: Get.context!,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            controller.selectedDate.value = picked;
                          }
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),

                            borderRadius: BorderRadius.circular(22),
                          ),

                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withOpacity(0.15),

                                  borderRadius: BorderRadius.circular(12),
                                ),

                                child: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color(0xFFD4AF37),
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    const Text(
                                      "Transaction Date",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(controller.selectedDate.value),

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ====================================
                    // BUTTONS
                    // ====================================
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 54,

                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withOpacity(0.4),
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: () {
                                controller.resetForm();
                              },

                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.refresh_rounded,
                                    color: Color(0xFFD4AF37),
                                  ),

                                  SizedBox(width: 8),

                                  Text(
                                    "Reset",
                                    style: TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          flex: 2,

                          child: SizedBox(
                            height: 54,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD4AF37),

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: () async {
                                // tambahkan konfirmasi dialog sebelum save

                                final confirm = await ConfirmDialog.show(
                                  title: "Simpan Transaction",
                                  message:
                                      "Apakah kamu yakin ingin menyimpan transaksi ini?",
                                  confirmText: "Simpan",
                                  confirmColor: const Color(0xFFD4AF37)
                                );
                                if (confirm) {
                                  controller.saveTransaction();
                                }
                              },

                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    "Save Income",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            
            ],
          ),
        ),
      ),
    );
  }

  // ====================================
  // MODERN INPUT
  // ====================================

  Widget _modernInputCard({
  required String title,
  required String hint,
  required IconData icon,
  required TextEditingController controller,
  int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // Label
      Row(
        children: [

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: const Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  hint,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
          ),
        ),
      ),
    ],
  );
}
  // ====================================
  // MODERN SELECTOR
  // ====================================

Widget _modernSelector({
  required String title,
  required String? value,
  required List<String> items,
  required IconData icon,
  required Function(String?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // Label
      Row(
        children: [

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "Pilih ${title.toLowerCase()}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,

            borderRadius: BorderRadius.circular(18),

            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFFD4AF37),
                size: 20,
              ),
            ),

            hint: Text(
              "Pilih $title",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),

            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),

            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),

            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}
}
