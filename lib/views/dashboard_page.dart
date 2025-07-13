import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/Dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  const DashboardPage({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController(userInfo));

    return Obx(() => Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTab,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: controller.selectedIndex.value == 0
          ? _buildDashboardView(controller)
          : controller.pages[controller.selectedIndex.value],
    ));
  }

  Widget _buildDashboardView(DashboardController controller) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(controller),
            const SizedBox(height: 20),
            _buildRevenueChartCard(),
            const SizedBox(height: 20),
            _buildInfoCards(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(DashboardController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/cabzings.png"),
        GestureDetector(
          onTap: controller.goToProfile,
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueChartCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("SAR 2,78,000.00",
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
              Text("Revenue",
                  style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          const Text("+21% than last month", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 1,
                maxX: 7,
                minY: 0,
                maxY: 4,
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text('${value.toInt()}',
                          style: const TextStyle(color: Colors.grey, fontSize: 10)),
                      reservedSize: 28,
                      interval: 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.cyanAccent,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, color: Colors.cyanAccent),
                    spots: const [
                      FlSpot(1, 0.5),
                      FlSpot(2, 2.8),
                      FlSpot(3, 2.3),
                      FlSpot(4, 3.8),
                      FlSpot(5, 3.2),
                      FlSpot(6, 2.4),
                      FlSpot(7, 2.2),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.center,
            child: Text("September 2023",
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final isSelected = index == 1;
              return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  '0${index + 1}',
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              );
            }),
          ),

        ],
      ),
    );
  }

  Widget _buildInfoCards(DashboardController controller) {
    return Column(
      children: [
        _infoCard(
          controller: controller,
          title: "Bookings",
          value: "123",
          subtitle: "Reserved",
          imageAsset: 'assets/images/bookings.png',
          iconBgColor: Colors.tealAccent,
          onTap: () => controller.navigateToBookings(Get.context!),
        ),
        _infoCard(
          controller: controller,
          title: "Sale List",
          value: "10,232.00",
          subtitle: "Rupees",
          imageAsset: 'assets/images/invoice.png',
          iconBgColor: Colors.lightBlueAccent,
          onTap: () => controller.navigateToInvoices(Get.context!),
        ),
      ],
    );
  }

  Widget _infoCard({
    required DashboardController controller,
    required String imageAsset,
    required Color iconBgColor,
    required String title,
    required String value,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(imageAsset, width: 40, height: 70, color: iconBgColor, fit: BoxFit.contain),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
                Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, size: 20, color: Colors.white54),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
