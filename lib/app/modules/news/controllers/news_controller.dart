import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/modules/news/models/newsresponse_model.dart';
import 'package:smartfin_mobile_app/app/services/api_service.dart';
import 'package:smartfin_mobile_app/app/services/storage_service.dart';

class NewsController extends GetxController {
  final ApiService api = ApiService();
  final StorageService storage = StorageService();

  final RxList<NewsModel> news = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;

  final searchController = TextEditingController();
  final RxString keyword = ''.obs;

  final RxList<NewsModel> filteredNews = <NewsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> getNews() async {
    try {
      isLoading.value = true;

      final token = storage.getToken();

      if (token == null || token.isEmpty) {
        throw Exception("Token tidak ditemukan");
      }

      final result = await api.getNews(token);

      news.assignAll(result);
      filteredNews.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchNews(String value) {
    keyword.value = value;

    if (value.trim().isEmpty) {
      filteredNews.assignAll(news);
      return;
    }

    final q = value.toLowerCase();

    filteredNews.assignAll(
      news.where((item) {
        return item.title.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q) ||
            item.source.toLowerCase().contains(q) ||
            item.category.toLowerCase().contains(q);
      }).toList(),
    );
  }

  Future<void> refreshNews() async {
    await getNews();
  }
}
