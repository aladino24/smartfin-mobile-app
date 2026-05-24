import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/notification_panel.dart';

class DashboardPage extends StatelessWidget {

  DashboardPage({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override

  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);
    // Tema Warna Konstan
    const Color primaryDark = Color(0xFF08111F);
    const Color accentGold = Color(0xFFD4AF37);
    const Color bgLight = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: bgLight,
      body: SafeArea(
        child: RefreshIndicator(
          color: accentGold, // Warna spinner loader
          backgroundColor: primaryDark, // Warna background spinner
          strokeWidth: 2.5,
          onRefresh: () => controller.refreshDashboardData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER USER
          
                _buildHeader(context, formattedDate),
          
                const SizedBox(height: 24),
          
                // 2. TOTAL BALANCE CARD
          
                _buildBalanceCard(accentGold),
          
                const SizedBox(height: 20),
          
                // 3. INCOME VS EXPENSE (Kanan - Kiri Modern)
          
                _buildIncomeExpense(),
          
                const SizedBox(height: 20),
          
                // 4. WALLET SUMMARY
          
                _buildWalletSummary(),
          
                const SizedBox(height: 20),
          
                // 5. FINANCIAL ANALYTICS (Bar & Pie Chart Terpadu)
                _buildAnalytics(),
          
                const SizedBox(height: 20),
          
                // 6. BUDGET PROGRESS
                _buildBudget(),
          
                const SizedBox(height: 20),
          
                // 7. RECENT TRANSACTIONS (Dengan pewarnaan pintar)
                _buildTransactions(),
          
                const SizedBox(height: 20),
          
                // 8. AI INSIGHTS (Gaya Edukatif/Robot AI Modern)
                _buildAIInsights(),
          
                const SizedBox(height: 20),
          
                // 9. SMART REMINDER
                _buildReminder(),
              ],
          
            ),
          
          ),
        ),

      ),

    );

  }



  // =====================================================

  // 1. HEADER

  // =====================================================

  Widget _buildHeader(BuildContext context, String date) { // <-- Tambah BuildContext di parameter
    return Obx(() => Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFFFECB3)]),
          ),
          child: (controller.avatar.isNotEmpty && controller.avatar != null) ? CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFF1E2A44),
            child:ClipOval(
              child: Image.network(
                controller.avatar,
                width: 52,
                height: 52,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.white, size: 28);
                },
              ),
            ),
          ) : CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFF1E2A44),
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
        ),

        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.w500),
              ),
              Text(
               controller.fullName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF08111F)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2), 
                child: Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),

            ],

          ),

        ),

        // ICON NOTIFIKASI DENGAN BADGE MODERN

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
          ),
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const NotificationPanel(), // <-- Panggil kelas di sini
              );
            },

            icon: Badge(
              backgroundColor: const Color(0xFFE71D36),
              label: const Text('2', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF08111F)),
            ),
          ),
                  )

      ],

    ));

  }


  // =====================================================

  // 2. BALANCE CARD (Ditambah Mini Line Chart Terintegrasi)

  // =====================================================

  Widget _buildBalanceCard(Color gold) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF08111F), Color(0xFF1A3154)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF08111F).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )

        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Balance", style: TextStyle(color: Colors.white60, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_upward_rounded, color: Colors.greenAccent, size: 14),
                    SizedBox(width: 4),
                    Text("+12%", style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          const Text(
            "Rp 12.500.000",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),

          const Text("vs Rp 11.160.000 bulan lalu", style: TextStyle(color: Colors.white38, fontSize: 12)),

          // Mini Sparkline Preview
          SizedBox(
            height: 50,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(1, 2.5),
                      const FlSpot(2, 4),
                      const FlSpot(3, 3.5),
                      const FlSpot(4, 5.5),
                    ],
                    isCurved: true,
                    color: gold,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: gold.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _QuickAction(icon: Icons.add_rounded, label: "Income"),
            _QuickAction(icon: Icons.remove_rounded, label: "Expense"),
            _QuickAction(icon: Icons.trending_up_rounded, label: "Invest"), 
            _QuickAction(icon: Icons.qr_code_scanner_rounded, label: "Scan"),
          ],
        ),
        ],
      ),

    );

  }



  // =====================================================

  // 3. INCOME VS EXPENSE (Berdampingan Modern)

  // =====================================================

    Widget _buildIncomeExpense() {

    return Row(
      children: [
        Expanded(
          child: _modernStatTile(
            title: "Income",
            amount: "Rp 15.000.000",
            period: "/ month", // <--- Tambah ini
            icon: Icons.arrow_downward_rounded,
            color: const Color(0xFF2EC4B6),
          ),

        ),

        const SizedBox(width: 14),
        Expanded(
          child: _modernStatTile(
            title: "Expense",
            amount: "Rp 8.500.000",
            period: "/ month", // <--- Tambah ini
            icon: Icons.arrow_upward_rounded,
            color: const Color(0xFFE71D36),
          ),

        ),

      ],

    );

  }





  Widget _modernStatTile({
    required String title,
    required String amount,
    required String period, // <--- Daftarkan parameter baru di sini
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),

                // Menggunakan RichText agar nominal dan periode menyatu dengan rapi namun beda ukuran/warna

                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Color(0xFF08111F)),
                    children: [
                      TextSpan(
                        text: amount,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: " $period",
                        style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.normal),
                      ),

                    ],

                  ),

                ),

              ],

            ),

          )

        ],

      ),

    );

  }



  // =====================================================

  // 4. WALLET SUMMARY

  // =====================================================

  Widget _buildWalletSummary() {
    return _sectionCard(
      title: "Wallet Summary",
      child: Column(
        children: const [
          _WalletRow("Cash Wallet", "Rp 1.000.000", Icons.payments_rounded, Color(0xFF4EA8DE)),
          _WalletRow("Bank BCA", "Rp 8.500.000", Icons.account_balance_rounded, Color(0xFF5390D9)),
          _WalletRow("OVO Balance", "Rp 350.000", Icons.account_balance_wallet_rounded, Color(0xFF740CDC)),
        ],
      ),

    );

  }



  // =====================================================

  // 5. FINANCIAL ANALYTICS (Bar Chart Modern)

  // =====================================================

  Widget _buildAnalytics() {
    return _sectionCard(
      title: "Financial Analytics",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weekly Overview", style: TextStyle(color: Colors.grey, fontSize: 13)),
              Text("Food & Cafe (Top)", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 13)),
            ],

          ),
          const SizedBox(height: 24),
          // Chart Implementasi fl_chart
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mn', 'Tu', 'Wd', 'Th', 'Fr', 'St', 'Sn'];
                        return Text(days[value.toInt() % 7], style: const TextStyle(color: Colors.grey, fontSize: 11));
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 5, 3),
                  _makeBarGroup(1, 7, 4),
                  _makeBarGroup(2, 4, 6),
                  _makeBarGroup(3, 8, 2),
                  _makeBarGroup(4, 6, 5),
                  _makeBarGroup(5, 9, 3),
                  _makeBarGroup(6, 4, 2),

                ],
              ),
            ),
          ),
        ],
      ),

    );

  }


  BarChartGroupData _makeBarGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: const Color(0xFF2EC4B6), width: 7, borderRadius: BorderRadius.circular(4)),
        BarChartRodData(toY: y2, color: const Color(0xFFE71D36), width: 7, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }



  // =====================================================

  // 6. BUDGET PROGRESS (Pie Matrix Visualisasi Custom)

  // =====================================================

  Widget _buildBudget() {
    return _sectionCard(
      title: "Budget Progress",
      child: Column(
        children: const [
          _BudgetItem("Food & Groceries", 0.75, "Rp 1.500.000 / Rp 2.000.000", Color(0xFFFFB703)),
          _BudgetItem("Transport & Gasoline", 0.40, "Rp 400.000 / Rp 1.000.000", Color(0xFF2196F3)),
          _BudgetItem("Entertainment & Movies", 0.92, "Rp 920.000 / Rp 1.000.000", Color(0xFFE71D36)),
        ],

      ),

    );

  }


  // =====================================================

  // 7. RECENT TRANSACTIONS (Pewarnaan Dinamis + Garis)

  // =====================================================

  Widget _buildTransactions() {
    return _sectionCard(
      title: "Recent Transactions",
      child: Column(
        children: const [
          _Transaction("Starbucks Coffee", "-50.000", "Today, 08:30 AM", Icons.coffee_rounded, Color(0xFFE71D36)),
          _Transaction("Monthly Salary", "+10.000.000", "Yesterday, 21:00 PM", Icons.wallet_membership_rounded, Color(0xFF2EC4B6)),
          _Transaction("Tokopedia Purchase", "-250.000", "22 May 2026", Icons.shopping_bag_rounded, Color(0xFFE71D36)),
        ],
      ),

    );

  }



  // =====================================================

  // 8. AI INSIGHTS (Desain Futuristik Cyber Glowing)

  // =====================================================

  Widget _buildAIInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2575FC).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )

        ],

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ilustrasi Efek Robot AI Bergerak/Berputar (Menggunakan Orbit Lingkaran)
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
              ),
              const _MovingAIIcon(), // Widget Custom Animasi Pendek
            ],
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SmartAI Analysis 🤖",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                _AIBulletText("Pengeluaran kafe kamu naik 25% pekan ini."),
                _AIBulletText("Disarankan menghemat Rp 500.000 untuk tabungan."),
                _AIBulletText("Portofolio Moderate siap dialokasikan ke reksa dana."),

              ],

            ),

          ),

        ],

      ),

    );

  }



  // =====================================================

  // 9. SMART REMINDER (Desain Glassmorphic Alert)

  // =====================================================

  Widget _buildReminder() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFC1BD), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Color(0xFFE71D36), shape: BoxShape.circle),
            child: const Icon(Icons.alarm_rounded, color: Colors.white, size: 20),
          ),

          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Smart Reminder", style: TextStyle(color: Color(0xFFE71D36), fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 2),
                Text("Langganan Netflix Premium jatuh tempo besok.", style: TextStyle(color: Color(0xFF5C1D24), fontSize: 13)),
              ],

            ),

          )

        ],

      ),

    );

  }



  // =====================================================

  // BASE REUSABLE CARD CONTROLLER

  // =====================================================

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF08111F)),
          ),
          const SizedBox(height: 16),
          child,
        ],

      ),

    );

  }

}



// ==============================================================================

// ATRIBUT SUB-WIDGET IMPLEMENTASI DETAILE

// ==============================================================================



class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Icon(icon, color: const Color(0xFFD4AF37)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500))
      ],

    );

  }

}



class _WalletRow extends StatelessWidget {
  final String name;
  final String balance;
  final IconData icon;
  final Color color;

  const _WalletRow(this.name, this.balance, this.icon, this.color);


  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF08111F))),
          ),
          Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF08111F))),
        ],

      ),

    );

  }

}


class _BudgetItem extends StatefulWidget {
  final String label;
  final double value;
  final String desc;
  final Color color;

  const _BudgetItem(this.label, this.value, this.desc, this.color);

  @override
  State<_BudgetItem> createState() => _BudgetItemState();

}


class _BudgetItemState extends State<_BudgetItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _controller.forward();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text("${(widget.value * 100).toInt()}%", style: TextStyle(color: widget.color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),

          const SizedBox(height: 6),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: Colors.grey.shade100,
                color: widget.color,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(widget.desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],

      ),

    );

  }

}



class _Transaction extends StatelessWidget {
  final String title;
  final String amount;
  final String time;
  final IconData icon;
  final Color typeColor;

  const _Transaction(this.title, this.amount, this.time, this.icon, this.typeColor);

  @override
  Widget build(BuildContext context) {
    bool isIncome = amount.startsWith('+');

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: const Color(0xFF08111F)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: Text(
          amount,
          style: TextStyle(
            color: isIncome ? const Color(0xFF2EC4B6) : const Color(0xFFE71D36),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

}



class _AIBulletText extends StatelessWidget {
  final String text;
  const _AIBulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("⚡ ", style: TextStyle(color: Colors.amber, fontSize: 12)),
          Expanded(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4))),
        ],
      ),
    );
  }
}



class _MovingAIIcon extends StatefulWidget {
  const _MovingAIIcon();

  @override
  State<_MovingAIIcon> createState() => _MovingAIIconState();
}



class _MovingAIIconState extends State<_MovingAIIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.insights_rounded, color: Color(0xFF2575FC), size: 24),
          ),
        );
      },
    );

  }

}

