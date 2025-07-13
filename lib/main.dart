import 'package:cabzing/views/dashboard_page.dart';
import 'package:cabzing/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Map<String, String>?> _checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    final userId = await storage.read(key: 'user_id');
    if (token != null && userId != null) {
      return {'token': token, 'userId': userId};
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: _buildHome(snapshot),
        );
      },
    );
  }

  Widget _buildHome(AsyncSnapshot<Map<String, String>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (snapshot.hasData) {
      final userInfo = snapshot.data!;
      return DashboardPage(userInfo: userInfo);
    }

    return const LoginPage();
  }
}
