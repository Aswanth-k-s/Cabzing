import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/invoice_controller.dart';
import 'filter_page.dart';

class InvoicesPage extends StatelessWidget {
  final int userId;
  const InvoicesPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoicesController(userId));
    final searchController = TextEditingController();

    void _navigateToFilterPage() async {
      final customerNames =
          controller.allBookings.map((b) => b.customerName).toSet().toList();

      final filters = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FiltersPage(customerList: customerNames),
        ),
      );

      if (filters != null) {
        controller.applyFilters(filters);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Invoices',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            color: Colors.white54, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            onChanged: controller.search,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _navigateToFilterPage,
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  label: const Text('Add Filters',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredBookings.isEmpty) {
                  return const Center(
                      child: Text('No matching results',
                          style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  itemCount: controller.filteredBookings.length,
                  itemBuilder: (context, index) {
                    final b = controller.filteredBookings[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.white10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Voucher: ${b.voucherNo}',
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 13)),
                              Text(b.status,
                                  style: TextStyle(
                                      color:
                                          controller.getStatusColor(b.status),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(b.customerName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              Text('SAR ${b.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
