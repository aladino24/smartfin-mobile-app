import 'dart:convert'; // Dibutuhkan untuk jsonEncode dan jsonDecode
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartfin_mobile_app/app/widgets/custom_dialog.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart'; // Import paket http

class ReminderController extends GetxController {
    final StorageService storage = StorageService();
  final ApiService api = ApiService();
  static const Color primaryColor = Color(0xFFD4AF37);
  static const Color lightBgColor = Color(0xFFFFFDF0);

  final TextEditingController titleController = TextEditingController(text: 'Bayar Tagihan Internet');

  // State Reaktif
  var selectedCategory = 'Tagihan'.obs;
  var selectedDate = DateTime(2025, 6, 25).obs;
  var selectedTime = const TimeOfDay(hour: 10, minute: 0).obs;
  var selectedRepeat = 'Setiap Bulan'.obs;
  var isNotificationEnabled = true.obs;


  final List<String> repeatOptions = [
    'Tidak Pernah', 'Setiap Hari', 'Setiap Minggu', 'Setiap Bulan', 'Setiap Tahun'
  ];

  String get formattedDate {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return "${selectedDate.value.day} ${months[selectedDate.value.month - 1]} ${selectedDate.value.year}";
  }

  String get formattedTime {
    final time = selectedTime.value;
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }

  // --- LOGIKA UNTUK MENGIRIM DATA MENGGUNAKAN HTTP PACKAGE ---
  Future<void> saveReminder() async {
    final token = storage.getToken();
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Peringatan', 'Judul reminder tidak boleh kosong!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
      );
      return;
    }

    // Tampilkan loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor))),
      barrierDismissible: false,
    );

    try {
      // 1. Format tanggal (YYYY-MM-DD) dan waktu (HH:MM)
      String rawDate = "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";
      String rawTime = "${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}";

      // 2. Susun Map data data
      Map<String, dynamic> payload = {
        'title': titleController.text.trim(),
        'category': selectedCategory.value,
        'reminder_date': rawDate,
        'reminder_time': rawTime,
        'repeat_interval': selectedRepeat.value,
        'is_notification_enabled': isNotificationEnabled.value,
      };

      // 3. Eksekusi HTTP POST Request
      final response = await http.post(
        Uri.parse("${api.baseUrl}/reminders"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload),
      );

      // Tutup loading dialog
      Get.back();

      if (response.statusCode == 201) {
        CustomDialog.success(
          title: "Berhasil",
          message: "Reminder berhasil disimpan!",
        );
      } else if (response.statusCode == 422) {
        // Jika terjadi error validasi dari Laravel
        var responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['errors']?.toString() ?? responseBody['message'];
        
        CustomDialog.error(
          title: "Validasi Gagal",
          message: errorMessage,
        );
      } else {
        // Error kode status lainnya (500, 404, dll)
        var responseBody = jsonDecode(response.body);
        CustomDialog.error(
          title: "Gagal",
          message: responseBody['message'] ?? 'Terjadi kesalahan saat menyimpan reminder.',
        );
      }
    } catch (e) {
      // Hubungan internet mati atau url salah masuk ke sini
      Get.back(); // Tutup loading
      CustomDialog.error(
        title: "Gagal",
        message: "Terjadi kesalahan: $e",
      );
    }
  }

  // --- Fungsi Pengubah State ---
  void changeCategory(String category) => selectedCategory.value = category;
  void selectRepeatOption(String option) => selectedRepeat.value = option;
  void toggleNotification(bool val) => isNotificationEnabled.value = val;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, initialDate: selectedDate.value, firstDate: DateTime(2020), lastDate: DateTime(2030),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: primaryColor)), child: child!),
    );
    if (picked != null) selectedDate.value = picked;
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context, initialTime: selectedTime.value,
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: primaryColor)), child: child!),
    );
    if (picked != null) selectedTime.value = picked;
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}