import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/wallet_controller.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  final WalletModuleController controller =
      Get.put(WalletModuleController());

  final currency = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Color parseColor(String hexColor) {
    try {
      return Color(
        int.parse(
          hexColor.replaceFirst('#', '0xFF'),
        ),
      );
    } catch (_) {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Add Wallet
        },
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        label: const Text(
          "Add Wallet",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshWallets,
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _header(),

                const SizedBox(height: 24),

                _totalBalanceCard(),

                const SizedBox(height: 20),

                _searchBox(),

                const SizedBox(height: 20),

                _walletStatistic(),

                const SizedBox(height: 20),

                _walletList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [

        const SizedBox(width: 14),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(
              0xFFD4AF37,
            ).withOpacity(0.15),
            borderRadius:
                BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            color: Color(0xFFD4AF37),
          ),
        ),

        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "My Wallet",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Text(
                "Manage your assets",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _totalBalanceCard() {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF08111F),
              Color(0xFF1A3154),
            ],
          ),
          borderRadius:
              BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Assets",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              currency.format(
                controller.totalBalance,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "${controller.wallets.length} Wallet Active",
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller:
          controller.searchController,
      decoration: InputDecoration(
        hintText: "Search wallet...",
        prefixIcon:
            const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _walletStatistic() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _statCard(
              "${controller.wallets.length}",
              "Wallet",
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: _statCard(
              "${controller.bankCount}",
              "Bank",
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: _statCard(
              "${controller.ewalletCount}",
              "E-Wallet",
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String value,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _walletList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(
              vertical: 50,
            ),
            child:
                CircularProgressIndicator(),
          ),
        );
      }

      return Column(
        children:
            controller.filteredWallets
                .map(
                  (wallet) {
                    final walletColor =
                        parseColor(
                      wallet.color,
                    );

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding:
                          const EdgeInsets.all(
                        18,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration:
                                BoxDecoration(
                              color:
                                  walletColor
                                      .withOpacity(
                                0.12,
                              ),
                              shape: BoxShape
                                  .circle,
                            ),
                            child: Icon(
                              controller
                                  .getWalletIcon(
                                wallet
                                    .walletType,
                              ),
                              color:
                                  walletColor,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  wallet
                                      .walletName,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize:
                                        15,
                                  ),
                                ),
                                Text(
                                  wallet
                                      .walletType,
                                ),
                              ],
                            ),
                          ),

                          Text(
                            currency.format(
                              wallet.balance,
                            ),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
                .toList(),
      );
    });
  }
}