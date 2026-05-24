import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  void saveToken(String token) {
    box.write("token", token);
  }

  String? getToken() {
    return box.read("token");
  }

  void clear() {
    box.erase();
  }
}