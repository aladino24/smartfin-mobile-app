import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("About App"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _header(),

          const SizedBox(height: 16),

          _infoCard(),

          const SizedBox(height: 16),

          _section(
            title: "Developer",
            children: const [
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Aladino Zulmar"),
                subtitle: Text("Fullstack Developer"),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Contact"),
                subtitle: Text("aladinozulmar@gmail.com"),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _section(
            title: "App Info",
            children: const [
              ListTile(
                leading: Icon(Icons.verified),
                title: Text("Version"),
                subtitle: Text("v1.0.0"),
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: Text("Category"),
                subtitle: Text("Finance Application"),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _section(
            title: "Features",
            children: const [
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text("Financial Management"),
                subtitle: Text("Kelola pemasukan dan pengeluaran"),
              ),
              ListTile(
                leading: Icon(Icons.trending_up),
                title: Text("Investment Tracking"),
                subtitle: Text("Pantau dan kelola portofolio investasi"),
              ),
              ListTile(
                leading: Icon(Icons.event_note),
                title: Text("Financial Planning"),
                subtitle: Text("Rencana keuangan jangka pendek & panjang"),
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text("Expense Analytics"),
                subtitle: Text("Analisis pengeluaran secara otomatis"),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _section(
            title: "Description",
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "SmartFin adalah aplikasi keuangan yang membantu kamu mengelola finansial secara menyeluruh, "
                  "mulai dari pencatatan pemasukan dan pengeluaran, perencanaan keuangan, hingga monitoring investasi. "
                  "Dengan SmartFin, kamu bisa merencanakan masa depan finansial dengan lebih terstruktur dan efisien.",
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              "© 2026 SmartFin",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2A44),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SmartFin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Finance • Investment • Planning App",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO CARD =================
  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About SmartFin",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "SmartFin adalah aplikasi keuangan yang membantu kamu mengelola finansial secara menyeluruh, "
            "mulai dari pencatatan pemasukan dan pengeluaran, perencanaan keuangan, hingga monitoring investasi. "
            "Dengan SmartFin, kamu bisa merencanakan masa depan finansial dengan lebih terstruktur dan efisien.",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // ================= SECTION =================
  Widget _section({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}