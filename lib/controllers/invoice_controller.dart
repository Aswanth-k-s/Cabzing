import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../services/api_service.dart' as api;

class InvoicesController extends GetxController {
  final int userId;
  InvoicesController(this.userId);

  var allBookings = <Booking>[].obs;
  var filteredBookings = <Booking>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() async {
    try {
      isLoading(true);
      final data = await api.fetchBookings(userId, 4);
      allBookings.assignAll(data);
      filteredBookings.assignAll(data);
    } finally {
      isLoading(false);
    }
  }

  void search(String query) {
    searchQuery.value = query;
    final q = query.toLowerCase();
    filteredBookings.assignAll(
      allBookings.where((b) =>
          b.customerName.toLowerCase().contains(q) ||
          b.voucherNo.toLowerCase().contains(q)),
    );
  }

  void applyFilters(Map<String, dynamic> filters) {
    final DateTime startDate = filters['startDate'];
    final DateTime endDate = filters['endDate'];
    final String status = filters['status'];
    final String customer = filters['customer'];

    filteredBookings.assignAll(
      allBookings.where((booking) {
        final matchDate =
            booking.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                booking.date.isBefore(endDate.add(const Duration(days: 1)));
        final matchStatus = status.isEmpty || booking.status == status;
        final matchCustomer =
            customer.isEmpty || booking.customerName == customer;
        return matchDate && matchStatus && matchCustomer;
      }),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Get.theme.colorScheme.error;
      case 'Invoiced':
        return Colors.blue;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}
