import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/confirm_dialog.dart';
import '../controller/income_transaction_controller.dart';

class IncomeTransactionPage
    extends StatelessWidget {
  IncomeTransactionPage({super.key});

  final controller = Get.put(
    IncomeTransactionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            children: [
              // ====================================
              // HEADER
              // ====================================

              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    decoration:
                        BoxDecoration(
                      gradient:
                          const LinearGradient(
                        colors: [
                          Color(
                            0xFFD4AF37,
                          ),
                          Color(
                            0xFFB8932F,
                          ),
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        22,
                      ),
                    ),

                    child: const Icon(
                      Icons
                          .trending_up_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        Text(
                          "Income Transaction",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "SmartFin AI Voice Assistant",
                          style: TextStyle(
                            color:
                                Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 28),

              // ====================================
              // VOICE CARD
              // ====================================

              Obx(
                () => Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration:
                      BoxDecoration(
                    gradient:
                        const LinearGradient(
                      begin:
                          Alignment.topLeft,
                      end: Alignment
                          .bottomRight,

                      colors: [
                        Color(0xFFD4AF37),
                        Color(0xFFB8932F),
                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      34,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(
                          0xFFD4AF37,
                        ).withOpacity(0.35),

                        blurRadius: 30,

                        offset:
                            const Offset(
                          0,
                          14,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.all(
                              14,
                            ),

                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white
                                  .withOpacity(
                                0.15,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                            ),

                            child: const Icon(
                              Icons
                                  .auto_awesome_rounded,
                              color:
                                  Colors.white,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  "AI Voice Income",
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white,
                                    fontSize:
                                        20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  "Hold button & speak your income",
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      GestureDetector(
                        onLongPressStart:
                            (_) async {
                          final allowed =
                              await controller
                                  .requestMicPermission();

                          if (!allowed) {
                            Get.dialog(
                              AlertDialog(
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    22,
                                  ),
                                ),

                                title:
                                    const Text(
                                  "Microphone Permission",
                                ),

                                content:
                                    const Text(
                                  "SmartFin membutuhkan akses microphone untuk menggunakan AI Voice Assistant.",
                                ),

                                actions: [
                                  TextButton(
                                    onPressed:
                                        () {
                                      Get.back();
                                    },
                                    child:
                                        const Text(
                                      "OK",
                                    ),
                                  ),
                                ],
                              ),
                            );

                            return;
                          }

                          controller
                              .startListening();
                        },

                        onLongPressEnd:
                            (_) {
                          controller
                              .stopListening();
                        },

                        child:
                            AnimatedContainer(
                          duration:
                              const Duration(
                            milliseconds:
                                250,
                          ),

                          width: controller
                                  .isListening
                                  .value
                              ? 145
                              : 120,

                          height: controller
                                  .isListening
                                  .value
                              ? 145
                              : 120,

                          decoration:
                              BoxDecoration(
                            shape:
                                BoxShape
                                    .circle,

                            gradient:
                                LinearGradient(
                              colors: controller
                                      .isListening
                                      .value
                                  ? [
                                      Colors
                                          .redAccent,
                                      Colors
                                          .red,
                                    ]
                                  : [
                                      Colors
                                          .white,
                                      Colors
                                          .white70,
                                    ],
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: controller
                                        .isListening
                                        .value
                                    ? Colors.red
                                        .withOpacity(
                                        0.5,
                                      )
                                    : Colors
                                        .white
                                        .withOpacity(
                                        0.5,
                                      ),

                                blurRadius:
                                    35,

                                spreadRadius:
                                    4,
                              ),
                            ],
                          ),

                          child: Icon(
                            controller
                                    .isListening
                                    .value
                                ? Icons
                                    .graphic_eq_rounded
                                : Icons
                                    .mic_rounded,

                            size: 58,

                            color: controller
                                    .isListening
                                    .value
                                ? Colors.white
                                : const Color(
                                    0xFFD4AF37,
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      Text(
                        controller
                                .isListening
                                .value
                            ? "Listening..."
                            : "Hold To Speak",

                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      AnimatedSwitcher(
                        duration:
                            const Duration(
                          milliseconds:
                              300,
                        ),

                        child: Text(
                          controller
                                  .speechText
                                  .value
                                  .isEmpty
                              ? "Contoh:\n'Gaji bulan ini 6200000 masuk ke BCA'"
                              : controller
                                  .speechText
                                  .value,

                          key: ValueKey(
                            controller
                                .speechText
                                .value,
                          ),

                          textAlign:
                              TextAlign.center,

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 15,
                            height: 1.7,
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
                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.04,
                      ),

                      blurRadius: 18,

                      offset:
                          const Offset(
                        0,
                        10,
                      ),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    _modernInputCard(
                      title:
                          "Income Title",
                      hint:
                          "Contoh: Gaji Bulanan",
                      icon: Icons
                          .edit_note_rounded,
                      controller:
                          controller
                              .titleController,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    _modernInputCard(
                      title:
                          "Description",
                      hint:
                          "Tambahkan deskripsi income",
                      icon:
                          Icons.notes_rounded,
                      controller:
                          controller
                              .descriptionController,
                      maxLines: 3,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

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

                          value: controller.walletController.wallets
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

                        const SizedBox(
                          width: 12,
                        ),

                       Expanded(
                        child: Obx(
                          () {
                            final items = controller.categoryController.categories
                                .map((c) => c.categoryName)
                                .toList();

                            return _modernSelector(
                              title: "Category",
                              icon: Icons.category_rounded,

                              value: items.contains(controller.selectedCategory.value)
                                  ? controller.selectedCategory.value
                                  : null,

                              items: items,

                              onChanged: (v) {
                                controller.selectedCategory.value = v ?? '';
                              },
                            );
                          },
                        ),
                      ),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // ====================================
                    // AMOUNT
                    // ====================================

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                        18,
                      ),

                      decoration:
                          BoxDecoration(
                        gradient:
                            LinearGradient(
                          colors: [
                            const Color(
                              0xFFD4AF37,
                            ).withOpacity(
                              0.08,
                            ),
                            Colors.white,
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          const Text(
                            "Amount",
                            style: TextStyle(
                              color:
                                  Colors.grey,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),

                          TextField(
                          controller:
                              controller.amountController,

                          keyboardType:
                              TextInputType.number,

                          onChanged: (value) {
                            value = value.replaceAll(".", "");

                            if (value.isEmpty) return;

                            final number =
                                int.tryParse(value);

                            if (number == null) return;

                            final formatted =
                                NumberFormat.decimalPattern(
                              'id',
                            ).format(number);

                            controller.amountController
                                .value = TextEditingValue(
                              text: formatted,
                              selection:
                                  TextSelection.collapsed(
                                offset: formatted.length,
                              ),
                            );
                          },

                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),

                          decoration:
                              const InputDecoration(
                            border: InputBorder.none,
                            prefixText: "Rp ",
                            prefixStyle: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD4AF37),
                            ),
                            hintText: "0",
                          ),
                        )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // ====================================
                    // DATE
                    // ====================================

                    Obx(
                      () => InkWell(
                        onTap: () async {
                          final picked =
                              await showDatePicker(
                            context:
                                Get.context!,
                            initialDate:
                                controller
                                    .selectedDate
                                    .value,
                            firstDate:
                                DateTime(
                                    2020),
                            lastDate:
                                DateTime(
                                    2100),
                          );

                          if (picked !=
                              null) {
                            controller
                                .selectedDate
                                .value = picked;
                          }
                        },

                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal:
                                18,
                            vertical: 16,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFFF8FAFC,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),
                          ),

                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                  10,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                    0xFFD4AF37,
                                  ).withOpacity(
                                    0.15,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),

                                child:
                                    const Icon(
                                  Icons
                                      .calendar_month_rounded,
                                  color:
                                      Color(
                                    0xFFD4AF37,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 14,
                              ),

                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [
                                    const Text(
                                      "Transaction Date",
                                      style:
                                          TextStyle(
                                        color:
                                            Colors.grey,
                                        fontSize:
                                            12,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          4,
                                    ),

                                    Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(
                                        controller
                                            .selectedDate
                                            .value,
                                      ),

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize:
                                            15,
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

                    const SizedBox(
                      height: 22,
                    ),

                    // ====================================
                    // BUTTONS
                    // ====================================

                    Row(
                      children: [
                        Expanded(
                          child:
                              SizedBox(
                            height: 54,

                            child:
                                OutlinedButton(
                              style:
                                  OutlinedButton.styleFrom(
                                side:
                                    BorderSide(
                                  color:
                                      const Color(
                                    0xFFD4AF37,
                                  ).withOpacity(
                                    0.4,
                                  ),
                                ),

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),

                              onPressed:
                                  () {
                                controller
                                    .resetForm();
                              },

                              child:
                                  const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons
                                        .refresh_rounded,
                                    color:
                                        Color(
                                      0xFFD4AF37,
                                    ),
                                  ),

                                  SizedBox(
                                      width:
                                          8),

                                  Text(
                                    "Reset",
                                    style:
                                        TextStyle(
                                      color:
                                          Color(
                                        0xFFD4AF37,
                                      ),
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 14),

                        Expanded(
                          flex: 2,

                          child:
                              SizedBox(
                            height: 54,

                            child:
                                ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFFD4AF37,
                                ),

                                elevation:
                                    0,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),

                              onPressed:
                                  () async {
                                // tambahkan konfirmasi dialog sebelum save

                                final confirm = await ConfirmDialog.show(
                                  title: "Simpan Transaction",
                                  message: "Apakah kamu yakin ingin menyimpan transaksi ini?",
                                  confirmText: "Simpan",
                                );
                                if (confirm) {
                                  controller.saveTransaction();
                                }
                              },

                              child:
                                  const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons
                                        .check_circle_rounded,
                                    color:
                                        Colors.white,
                                  ),

                                  SizedBox(
                                      width:
                                          10),

                                  Text(
                                    "Save Income",
                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize:
                                          16,
                                      fontWeight:
                                          FontWeight.bold,
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
    required TextEditingController
        controller,
    int maxLines = 1,
  }) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFFF8FAFC),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color:
                    const Color(0xFFD4AF37),
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller,
            maxLines: maxLines,

            decoration:
                InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
              hintStyle:
                  const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
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
    required Function(String?)
        onChanged,
  }) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFFF8FAFC),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color:
                    const Color(0xFFD4AF37),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  title,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          DropdownButtonHideUnderline(
            child:
                DropdownButton<String>(
              value: value,

              isExpanded: true,

              icon: const Icon(
                Icons
                    .keyboard_arrow_down_rounded,
                size: 18,
              ),

              style: const TextStyle(
                color:
                    Color(0xFF1E293B),
                fontSize: 14,
                fontWeight:
                    FontWeight.bold,
              ),

              items: items
                  .map(
                    (e) =>
                        DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        overflow:
                            TextOverflow
                                .ellipsis,
                      ),
                    ),
                  )
                  .toList(),

              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}