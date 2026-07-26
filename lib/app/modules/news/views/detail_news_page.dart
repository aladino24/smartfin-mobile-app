import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/newsresponse_model.dart';

class DetailNewsPage extends StatelessWidget {
  DetailNewsPage({super.key});

  final NewsModel news = Get.arguments as NewsModel;

  Future<void> openNews() async {
    final uri = Uri.parse(news.url);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat membuka artikel");
    }
  }

  String formatDate(String date) {
    try {
      final dateTime = DateTime.parse(date).toLocal();

      return DateFormat('dd MMMM yyyy • HH:mm', 'id_ID').format(dateTime);
    } catch (e) {
      print(e);
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color gold = Color(0xffD4AF37);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,

            pinned: true,

            backgroundColor: Colors.white,

            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: news.id,

                child: Image.network(news.image, fit: BoxFit.cover),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: gold,

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Text(
                      news.category,

                      style: const TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    news.title,

                    style: const TextStyle(
                      fontSize: 28,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.public, size: 18, color: Colors.grey),

                      const SizedBox(width: 6),

                      Text(news.source),

                      const Spacer(),

                      Text(formatDate(news.publishedAt)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Summary",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    news.description,

                    style: const TextStyle(fontSize: 16, height: 1.8),
                  ),

                  const SizedBox(height: 25),

                  const Divider(),

                  const SizedBox(height: 20),

                  const Text(
                    "News Detail",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    news.content,

                    style: const TextStyle(fontSize: 16, height: 1.8),
                  ),

                  const SizedBox(height: 30),

                  // Container(
                  //   padding: const EdgeInsets.all(20),

                  //   decoration: BoxDecoration(
                  //     color: Colors.white,

                  //     borderRadius: BorderRadius.circular(20),

                  //     border: Border.all(color: gold),
                  //   ),

                  //   child: const Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,

                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(Icons.auto_awesome, color: gold),

                  //           SizedBox(width: 10),

                  //           Text(
                  //             "SmartFin AI Insight",

                  //             style: TextStyle(
                  //               fontSize: 18,

                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),

                  //       SizedBox(height: 18),

                  //       Text("• Dampak terhadap pasar masih netral."),

                  //       SizedBox(height: 8),

                  //       Text(
                  //         "• Investor disarankan memperhatikan perkembangan berita berikutnya.",
                  //       ),

                  //       SizedBox(height: 8),

                  //       Text("• Sentimen: 🟢 Bullish"),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: openNews,

                      icon: const Icon(Icons.open_in_new, color: Colors.white),

                      label: const Text(
                        "Baca Artikel Asli",

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
