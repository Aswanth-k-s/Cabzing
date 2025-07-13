import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../services/secure_storage_service.dart';
import '../views/dashboard_page.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final SecureStorageService _storage = SecureStorageService();

  var isLoading = false.obs;

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (username.isEmpty || password.isEmpty) {
      showError('Please enter both username and password');
      return;
    }

    isLoading.value = true;

    final loginUrl =
        Uri.parse('https://api.accounts.vikncodes.com/api/v1/users/login');
    final body = json.encode({
      'username': username,
      'password': password,
      'is_mobile': true,
    });

    try {
      final response = await http.post(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final resp = json.decode(response.body);
      print('Login response: $resp');

      if (response.statusCode == 200 && resp['data'] != null) {
        final token = resp['data']['access'];
        final userIdVal = resp['data']['user_id'] as int;

        await _storage.saveToken(token);
        await _storage.saveUserId(userIdVal);

        final userInfo = {
          'user_id': resp['data']['user_id'],
          'username': resp['data']['username'],
          'email': resp['data']['email'],
          'role': resp['data']['role'],
          'last_login': resp['data']['last_login'],
          'token': token,
        };

        Get.off(() => DashboardPage(userInfo: userInfo));
      } else {
        showError(resp['message'] ?? 'Login failed');
      }
    } catch (e) {
      showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    formKey.currentState?.reset();
    usernameController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void showError(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK')),
        ],
      ),
    );
  }
}
