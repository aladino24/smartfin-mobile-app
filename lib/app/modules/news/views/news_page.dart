import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/news/controllers/news_controller.dart';
import 'package:smartfin_mobile_app/app/modules/news/models/newsresponse_model.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Financial News",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
            color: primary,
          ));
        }

        final NewsModel? headline = controller.filteredNews.isNotEmpty
            ? controller.filteredNews.first
            : null;

        return RefreshIndicator(
          onRefresh: controller.refreshNews,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              /// SEARCH
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.searchNews,
                  decoration: InputDecoration(
                    hintText: "Search financial news...",
                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: controller.keyword.value.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              controller.searchController.clear();
                              controller.searchNews("");
                            },
                          ),

                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// EMPTY SEARCH
              if (headline == null) ...[
                const SizedBox(height: 60),

                Icon(
                  Icons.search_off_rounded,
                  size: 90,
                  color: Colors.grey.shade400,
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "No news found",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    "Try another keyword",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.searchController.clear();
                      controller.searchNews("");
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Clear Search"),
                  ),
                ),
              ]
              /// DATA ADA
              else ...[
                /// HERO NEWS
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(headline.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Chip(
                          label: Text("BREAKING"),
                          backgroundColor: Color(0xFFD4AF37),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          headline.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          headline.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(
                              Icons.public,
                              color: Colors.white70,
                              size: 14,
                            ),

                            const SizedBox(width: 5),

                            Expanded(
                              child: Text(
                                headline.source,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),

                            Text(
                              headline.category,
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Latest News",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredNews.length,
                  itemBuilder: (_, index) {
                    return NewsCard(news: controller.filteredNews[index]);
                  },
                ),

                const SizedBox(height: 25),

                // Container(
                //   padding: const EdgeInsets.all(18),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(22),
                //     border: Border.all(color: const Color(0xFFD4AF37)),
                //   ),
                //   child: const Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(Icons.auto_awesome, color: Color(0xFFD4AF37)),
                //           SizedBox(width: 8),
                //           Text(
                //             "AI Market Insight",
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 17,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: 15),
                //       Text(
                //         "IHSG mengalami tekanan akibat kenaikan harga minyak dan aksi jual investor asing. Investor disarankan tetap fokus pada saham fundamental yang kuat.",
                //       ),
                //       SizedBox(height: 15),
                //       Text(
                //         "✨ Generated by SmartFin AI",
                //         style: TextStyle(color: Colors.grey),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 30),
              ],
            ],
          ),
        );
      }),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;

  const CategoryChip({super.key, required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        backgroundColor: selected ? const Color(0xFFD4AF37) : Colors.white,
        label: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/news/detail', arguments: news),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                news.image,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    news.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "${news.source} • ${news.category}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
