import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartfin_mobile_app/app/modules/transaction/controller/transaction_history_controller.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final controller = Get.put(TransactionHistoryController());

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF08111F),
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingTransaction.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.transactions.isEmpty) {
                return const Center(
                  child: Text("No transactions found"),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.transactions.length,
                itemBuilder: (_, index) {
                  final tx = controller.transactions[index];

                  final isIncome = tx.transactionType == "income";

                  final mainColor = isIncome
                      ? const Color(0xFF2EC4B6)
                      : const Color(0xFFE71D36);

                  final bgColor = isIncome
                      ? const Color(0xFF2EC4B6).withOpacity(.12)
                      : const Color(0xFFE71D36).withOpacity(.12);

                  final icon = isIncome
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.03),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: bgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: mainColor,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('dd MMM yyyy • HH:mm')
                                    .format(tx.transactionDate),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${isIncome ? '+' : '-'} ${controller.formatRupiah(tx.amount)}",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Text(
                                isIncome ? "Income" : "Expense",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          /// SEARCH
          TextField(
            controller: controller.searchController,
            onChanged: (v) {
              controller.search.value = v;
            },
            decoration: InputDecoration(
              hintText: "Search transaction...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF5F6FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// FILTER CHIP
          Obx(() {
            return Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text("All"),
                  selected: controller.typeFilter.value == "all",
                  onSelected: (_) =>
                      controller.typeFilter.value = "all",
                ),
                ChoiceChip(
                  label: const Text("Income"),
                  selected: controller.typeFilter.value == "income",
                  onSelected: (_) =>
                      controller.typeFilter.value = "income",
                ),
                ChoiceChip(
                  label: const Text("Expense"),
                  selected: controller.typeFilter.value == "expense",
                  onSelected: (_) =>
                      controller.typeFilter.value = "expense",
                ),
              ],
            );
          }),

          const SizedBox(height: 16),

          /// DATE FILTER
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final result = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );

                if (result != null) {
                  controller.startDate.value = result.start;
                  controller.endDate.value = result.end;
                }
              },
              icon: const Icon(Icons.calendar_today_outlined, color: Colors.black,),
              label: Obx(() {
                if (controller.startDate.value == null) {
                  return const Text("Select Date", style: TextStyle(color: Colors.black),);
                }

                return Text(
                  "${DateFormat('dd MMM').format(controller.startDate.value!)} - ${DateFormat('dd MMM yyyy').format(controller.endDate.value!)}",
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}