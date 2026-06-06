import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../widgets/custom_dialog.dart';
import '../model/knowledgenode.dart';
import '../views/image_viewer_page.dart';
import '../views/pdf_viewer_page.dart';

class KnowledgeController extends GetxController {
  final isLoading = false.obs;

  final tree = <KnowledgeNode>[].obs;

  final StorageService storage = StorageService();

  // base url
  final String baseUrl = ApiService().baseUrl;

  @override
  void onInit() {
    super.onInit();
    loadKnowledge();
  }

  Future<void> loadKnowledge() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(
          '$baseUrl/knowledge/tree',
        ),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${storage.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        final json =
            jsonDecode(response.body);

        final List data =
            json['data'] ?? [];

        tree.assignAll(
          data
              .map(
                (e) => KnowledgeNode.fromJson(e),
              )
              .toList(),
        );
      } else {
        CustomDialog.error(
          title: "Error",
          message: "Failed to load knowledge tree",
        );
      }
    } catch (e) {
      CustomDialog.error(
        title: "Error",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

   Future<void> openFile(KnowledgeNode node) async {

    if (node.url == null ||
        node.url!.isEmpty) {
      Get.snackbar(
        "Error",
        "File tidak ditemukan",
      );
      return;
    }

    final ext =
        node.extension?.toLowerCase() ?? '';

    // PDF
    if (ext == 'pdf') {
      Get.to(
        () => PdfViewerPage(
          title: node.name,
          url: node.url!,
        ),
      );
      return;
    }

    // IMAGE
    if ([
      'jpg',
      'jpeg',
      'png',
      'webp'
    ].contains(ext)) {
      Get.to(
        () => ImageViewerPage(
          title: node.name,
          imageUrl: node.url!,
        ),
      );
      return;
    }

    // FILE LAIN
    final uri = Uri.parse(
      node.url!,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode:
            LaunchMode
                .externalApplication,
      );
    }
  }

  Future<void> refreshData() async {
    await loadKnowledge();
  }
}