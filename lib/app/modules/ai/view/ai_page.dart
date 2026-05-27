import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController messageController =
      TextEditingController();

  final RxList<ChatMessage> messages =
      <ChatMessage>[].obs;

  @override
  void initState() {
    super.initState();

    messages.add(
      ChatMessage(
        isUser: false,
        message:
            "Halo 👋 Saya SmartFin AI.\n\nBerdasarkan transaksi bulan ini, pengeluaran terbesar Anda berada pada kategori Food & Beverage sebesar Rp1.850.000.\n\nSaya siap membantu analisa keuangan, budgeting, investasi, dan perencanaan finansial Anda.",
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;

    messages.add(
      ChatMessage(
        isUser: true,
        message: messageController.text,
      ),
    );

    messageController.clear();

    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        messages.add(
          ChatMessage(
            isUser: false,
            message:
                "Berdasarkan data yang tersedia, saya menyarankan mengalokasikan 20% dari pendapatan ke instrumen investasi berisiko rendah hingga menengah untuk menjaga keseimbangan cashflow.",
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      body: SafeArea(
        child: Column(
          children: [
            _header(),

            Expanded(
              child: Obx(
                () => ListView(
                  padding:
                      const EdgeInsets.all(20),
                  children: [
                    _premiumAiCard(),

                    const SizedBox(height: 20),

                    _quickPrompts(),

                    const SizedBox(height: 24),

                    ...messages.map(
                      (e) => _chatBubble(e),
                    ),
                  ],
                ),
              ),
            ),

            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD4AF37),
                  Color(0xFFFFE082),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.black,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "SmartFin AI",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                Text(
                  "Personal Financial Advisor",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history_rounded,
            ),
          )
        ],
      ),
    );
  }

  Widget _premiumAiCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF08111F),
            Color(0xFF1A3154),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.insights,
                color: Color(0xFFD4AF37),
              ),

              const SizedBox(width: 8),

              Text(
                "Today's Insight",
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.9),
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Pengeluaran Anda turun 12% dibanding minggu lalu.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Momentum yang baik untuk meningkatkan porsi investasi bulanan.",
            style: TextStyle(
              color: Colors.white
                  .withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickPrompts() {
    final prompts = [
      "Analisa pengeluaran saya",
      "Saran investasi",
      "Buat budget bulanan",
      "Tips menabung",
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return ActionChip(
            label: Text(prompts[i]),
            onPressed: () {
              messageController.text =
                  prompts[i];
            },
          );
        },
        separatorBuilder:
            (_, __) =>
                const SizedBox(width: 8),
        itemCount: prompts.length,
      ),
    );
  }

  Widget _chatBubble(
    ChatMessage message,
  ) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 14,
        ),
        constraints:
            const BoxConstraints(
          maxWidth: 300,
        ),
        padding:
            const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(
                  0xFFD4AF37)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(
            22,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: isUser
                ? Colors.black
                : const Color(
                    0xFF08111F),
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller:
                  messageController,
              decoration:
                  InputDecoration(
                hintText:
                    "Ask SmartFin AI...",
                filled: true,
                fillColor:
                    const Color(
                  0xFFF5F7FA,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Container(
            decoration:
                const BoxDecoration(
              shape: BoxShape.circle,
              gradient:
                  LinearGradient(
                colors: [
                  Color(0xFFD4AF37),
                  Color(0xFFFFE082),
                ],
              ),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatMessage {
  final bool isUser;
  final String message;

  ChatMessage({
    required this.isUser,
    required this.message,
  });
}