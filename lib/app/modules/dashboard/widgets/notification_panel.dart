import 'package:flutter/material.dart';

class NotificationPanel extends StatefulWidget {
  const NotificationPanel({super.key});

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel> {
  // Simulasi data notifikasi (menggunakan List agar kondisinya bisa dimanipulasi/diubah)
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Dividen Saham Cair 🎉",
      "description": "Selamat! Dividen BBCA sebesar Rp 150.000 otomatis tercatat masuk ke instrumen investasi kamu.",
      "time": "10 mins ago",
      "isUnread": true,
      "icon": Icons.trending_up_rounded,
      "color": const Color(0xFF2EC4B6),
    },
    {
      "title": "Limit Anggaran Makanan ⚠️",
      "description": "Pengeluaran pos 'Food & Groceries' kamu sudah mencapai 75% dari budget bulanan.",
      "time": "2 hours ago",
      "isUnread": true,
      "icon": Icons.warning_amber_rounded,
      "color": const Color(0xFFFFB703),
    },
    {
      "title": "SmartAI Financial Report 🤖",
      "description": "Analisis finansial mingguan kamu sudah siap. Intip strategi penghematan terbarumu sekarang!",
      "time": "Yesterday",
      "isUnread": false,
      "icon": Icons.insights_rounded,
      "color": const Color(0xFF2575FC),
    },
    {
      "title": "Pencatatan Berhasil",
      "description": "Berhasil menambahkan pengeluaran 'Starbucks Coffee' sebesar Rp 50.000.",
      "time": "22 May 2026",
      "isUnread": false,
      "icon": Icons.receipt_long_rounded,
      "color": Colors.grey,
    },
  ];

  // Fungsi untuk menandai semua notifikasi sebagai dibaca
  void _markAllAsRead() {
    setState(() {
      for (var notif in _notifications) {
        notif["isUnread"] = false;
      }
    });
  }

  // Fungsi untuk menandai satu item saja sebagai dibaca saat di-klik
  void _markAsRead(int index) {
    setState(() {
      _notifications[index]["isUnread"] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle Bar Atas (Gaya iOS Modern)
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 18),

          // Header Lembar Notifikasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Activity & Notifications",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF08111F),
                  ),
                ),
                TextButton(
                  onPressed: _markAllAsRead,
                  child: const Text(
                    "Mark all as read",
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1),

          // Daftar Aktivitas Masuk
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return InkWell(
                  onTap: () => _markAsRead(index), // Klik untuk menandai sudah dibaca
                  child: _buildNotificationItem(
                    title: item["title"],
                    description: item["description"],
                    time: item["time"],
                    isUnread: item["isUnread"],
                    icon: item["icon"],
                    iconBgColor: item["color"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Komponent Item Baris Notifikasi
  Widget _buildNotificationItem({
    required String title,
    required String description,
    required String time,
    required bool isUnread,
    required IconData icon,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFD4AF37).withOpacity(0.03) : Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconBgColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    color: const Color(0xFF08111F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnread ? Colors.black : Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 4, left: 8),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD4AF37),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}