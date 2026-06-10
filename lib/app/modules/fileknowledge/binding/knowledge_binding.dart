import 'package:get/get.dart';

import '../controller/knowledgenode_controller.dart';


class KnowledgeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KnowledgeController>(
      () => KnowledgeController(),
    );
  }
}