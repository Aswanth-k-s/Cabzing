import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/secure_storage_service.dart';
import '../views/about_page.dart';
import '../views/bookings_page.dart';
import '../views/invoice_page.dart';
import '../views/orders_page.dart';
import '../views/profile_page.dart';
import '../views/settings_page.dart';

class DashboardController extends GetxController {
  final storage = SecureStorageService();
  final selectedIndex = 0.obs;

  late List<Widget> pages;
  final Map<String, dynamic> userInfo;

  DashboardController(this.userInfo);

  @override
  void onInit() {
    pages = [
      Container(),
      const ordersPage(),
      const AboutPage(),
      const SettingsPage(),
    ];
    super.onInit();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> navigateToBookings(BuildContext context) async {
    final userId = await storage.readUserId();
    if (userId != null) {
      Get.to(() => BookingsPage(userId: userId));
    } else {
      Get.snackbar("Error", "Please log in again.");
    }
  }

  Future<void> navigateToInvoices(BuildContext context) async {
    final userId = await storage.readUserId();
    if (userId != null) {
      Get.to(() => InvoicesPage(userId: userId));
    } else {
      Get.snackbar("Error", "Please log in again.");
    }
  }

  void goToProfile() {
    Get.to(() => ProfilePage(userInfo: userInfo));
  }
}
