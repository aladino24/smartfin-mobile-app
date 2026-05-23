import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../models/category_model.dart';


class CategoryController extends GetxController {
  RxList<CategoryModel> categories =
    <CategoryModel>[].obs;

  RxString selectedWallet =
      ''.obs;
   final StorageService storage = StorageService();
  final ApiService api = ApiService();

  Future<void> loadCategory(String tipe) async {
      try {
        final token = storage.getToken();

        final result =
            await api.getCategories(
          token.toString(),
        );

        categories.value = result.where((c) => c.categoryType == tipe).toList();

        if (categories.isNotEmpty) {
          selectedWallet.value =
              categories.first.categoryName;
        }
      } catch (e) {
        print(e);
      }
    }
}