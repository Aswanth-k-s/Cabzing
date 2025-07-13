import 'dart:ui';
import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../services/api_service.dart';

class BookingsController extends GetxController {
  final int userId;
  BookingsController(this.userId);

  var bookings = <Booking>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchBookingsData();
    super.onInit();
  }

  void fetchBookingsData() async {
    try {
      isLoading.value = true;
      final data = await fetchBookings(userId, 4);
      bookings.value = data;
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Get.theme.colorScheme.error;
      case 'Invoiced':
        return Get.theme.colorScheme.primary;
      case 'Cancelled':
        return Get.theme.disabledColor;
      default:
        return Get.theme.primaryColor;
    }
  }
}
