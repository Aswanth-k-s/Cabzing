import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FiltersController extends GetxController {
  final List<String> customerList;

  FiltersController(this.customerList);

  Rx<DateTime> startDate = DateTime.now().subtract(Duration(days: 30)).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString selectedStatus = 'Pending'.obs;
  RxString selectedCustomer = ''.obs;

  List<String> get statusOptions => ['Pending', 'Invoiced', 'Cancelled'];

  void applyFilters() {
    Get.back(result: {
      'startDate': startDate.value,
      'endDate': endDate.value,
      'status': selectedStatus.value,
      'customer': selectedCustomer.value,
    });
  }
}
