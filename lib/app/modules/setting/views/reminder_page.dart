import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfin_mobile_app/app/widgets/confirm_dialog.dart';
import '../controllers/reminder_controller.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final ReminderController controller = Get.put(ReminderController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Buat Reminder',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Atur pengingat keuangan Anda',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.notifications, size: 36, color: ReminderController.primaryColor),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 10, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- JUDUL REMINDER ---
              const Text('Judul Reminder', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 8),
              TextField(
                controller: controller.titleController,
                onChanged: (value) => controller.update(), // Update UI preview jika teks berubah
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.assignment_outlined, color: ReminderController.primaryColor),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                    onPressed: () {
                      controller.titleController.clear();
                      controller.update();
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                ),
              ),
              const SizedBox(height: 24),

              // --- KATEGORI ---
              const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryCard(controller, 'Tagihan', Icons.wifi, ReminderController.primaryColor),
                  _buildCategoryCard(controller, 'Investasi', Icons.trending_up, Colors.green),
                  _buildCategoryCard(controller, 'Tabungan', Icons.savings, Colors.blue),
                  _buildCategoryCard(controller, 'Asuransi', Icons.shield, Colors.orange),
                  _buildCategoryCard(controller, 'Lainnya', Icons.more_horiz, Colors.grey),
                ],
              )),
              const SizedBox(height: 24),

              // --- TANGGAL & WAKTU PENGINGAT ---
              const Text('Tanggal & Waktu Pengingat', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Obx(() => Column(
                  children: [
                    _buildDateTimeTile(Icons.calendar_today, 'Tanggal', controller.formattedDate, () => controller.pickDate(context)),
                    Divider(height: 1, color: Colors.grey.shade100),
                    _buildDateTimeTile(Icons.access_time, 'Waktu', controller.formattedTime, () => controller.pickTime(context)),
                  ],
                )),
              ),
              const SizedBox(height: 24),

              // --- ULANGI ---
              const Text('Ulangi', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => _showRepeatBottomSheet(context, controller),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: ReminderController.lightBgColor, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.repeat, color: ReminderController.primaryColor, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Obx(() => Text(controller.selectedRepeat.value, style: const TextStyle(fontWeight: FontWeight.w500))),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- NOTIFIKASI ---
              const Text('Notifikasi', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ReminderController.lightBgColor),
                ),
                child: Obx(() => Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: ReminderController.lightBgColor, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.notifications_none, color: ReminderController.primaryColor, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Kirim pengingat sebelum waktu utama', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF1E293B))),
                              Text('Anda akan menerima push notification', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                            ],
                          ),
                        ),
                        Switch(
                          value: controller.isNotificationEnabled.value,
                          activeColor: ReminderController.primaryColor,
                          onChanged: controller.toggleNotification,
                        )
                      ],
                    ),
                    if (controller.isNotificationEnabled.value) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ingatkan saya', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                            const Row(
                              children: [
                                Text('1 hari sebelumnya', style: TextStyle(color: Color(0xFF1E293B), fontSize: 13, fontWeight: FontWeight.w500)),
                                Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
                              ],
                            )
                          ],
                        ),
                      )
                    ]
                  ],
                )),
              ),
              const SizedBox(height: 24),

              // --- PREVIEW PENGINGAT ---
              const Text('Preview Pengingat', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4FBF7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6F7ED)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: Color(0xFFE6F7ED), shape: BoxShape.circle),
                      child: Obx(() => Icon(
                        controller.selectedCategory.value == 'Tagihan'
                            ? Icons.wifi
                            : controller.selectedCategory.value == 'Investasi'
                                ? Icons.trending_up
                                : controller.selectedCategory.value == 'Tabungan'
                                    ? Icons.savings
                                    : controller.selectedCategory.value == 'Asuransi'
                                        ? Icons.shield
                                        : Icons.more_horiz,
                        color: ReminderController.primaryColor,
                      )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFFE6F7ED), borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              controller.isNotificationEnabled.value ? 'Akan dikirim • 1 hari sebelum waktu utama' : 'Notifikasi Dinonaktifkan',
                              style: const TextStyle(color: Color(0xFF22C55E), fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedBuilder(
                            animation: controller.titleController,
                            builder: (context, _) {
                              return Text(
                                controller.titleController.text.isEmpty ? 'Tanpa Judul' : controller.titleController.text,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B)),
                              );
                            }
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                              const SizedBox(width: 4),
                              Text('${controller.formattedDate}, ${controller.formattedTime}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.repeat, size: 12, color: Colors.grey[500]),
                              const SizedBox(width: 4),
                              Text(controller.selectedRepeat.value, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // --- BUTTON SIMPAN REMINDER ---
             SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  final confirm = ConfirmDialog.show(title: 'Konfirmasi', message: 'Apakah anda yakin menyimpan reminder ini?');

                  confirm.then((confirmed) {
                    if (confirmed == true) {
                      controller.saveReminder();
                    }
                  });
                },
                icon: const Icon(Icons.send, size: 18, color: Colors.white),
                label: const Text('Simpan Reminder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ReminderController.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Sheet UI helper
  void _showRepeatBottomSheet(BuildContext context, ReminderController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pilih Pengulangan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 10),
              Obx(() => Column(
                children: controller.repeatOptions.map((option) => ListTile(
                  title: Text(option, style: TextStyle(fontWeight: controller.selectedRepeat.value == option ? FontWeight.bold : FontWeight.normal)),
                  trailing: controller.selectedRepeat.value == option ? const Icon(Icons.check, color: ReminderController.primaryColor) : null,
                  onTap: () {
                    controller.selectRepeatOption(option);
                    Navigator.pop(context);
                  },
                )).toList(),
              )),
            ],
          ),
        );
      },
    );
  }

  // Helper Widget Kategori Card
  Widget _buildCategoryCard(ReminderController controller, String title, IconData icon, Color defaultColor) {
    final bool isSelected = controller.selectedCategory.value == title;
    return InkWell(
      onTap: () => controller.changeCategory(title),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 68,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? ReminderController.lightBgColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? ReminderController.primaryColor : Colors.grey.shade100, width: isSelected ? 1.5 : 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: ReminderController.primaryColor, shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: isSelected ? ReminderController.primaryColor : defaultColor, size: 24),
                const SizedBox(height: 8),
                Text(title, style: TextStyle(fontSize: 11, color: isSelected ? ReminderController.primaryColor : Colors.grey[600], fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget Tanggal & Waktu Tile
  Widget _buildDateTimeTile(IconData icon, String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: ReminderController.lightBgColor, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: ReminderController.primaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}