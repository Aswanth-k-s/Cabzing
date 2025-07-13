import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookings_controller.dart';

class BookingsPage extends StatelessWidget {
  final int userId;
  const BookingsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingsController(userId));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Bookings', style: TextStyle(color: Colors.white)),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
              child: Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.white)));
        }

        if (controller.bookings.isEmpty) {
          return const Center(
              child: Text('No bookings found.',
                  style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.bookings.length,
          itemBuilder: (context, i) {
            final b = controller.bookings[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Voucher: ${b.voucherNo}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        b.billwiseStatus,
                        style: TextStyle(
                          color: controller.getStatusColor(b.status),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        b.customerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${b.date.day}/${b.date.month}/${b.date.year}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'SAR ${b.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
