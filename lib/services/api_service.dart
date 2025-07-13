import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking_model.dart';
import '../services/secure_storage_service.dart';

Future<List<Booking>> fetchBookings(int userId, int pageNumber) async {
  final token = await SecureStorageService().readToken();
  if (token == null) throw Exception('Unauthorized: no token found');

  final payload = {
    'BranchID': 1,
    'CompanyID': '1901b825-fe6f-418d-b5f0-7223d0040d08',
    'CreatedUserID': userId,
    'PriceRounding': 2,
    'page_no': pageNumber,
    'items_per_page': 50,
    'type': 'Sales',
    'WarehouseID': 1,
  };

  final response = await http
      .post(
        Uri.parse(
            'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(payload),
      )
      .timeout(const Duration(seconds: 10));

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'] as List<dynamic>;
    return data
        .map((e) => Booking.fromJson(e as Map<String, dynamic>))
        .toList();
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized: token expired or invalid');
  } else {
    throw Exception('Failed to load bookings: ${response.statusCode}');
  }
}
