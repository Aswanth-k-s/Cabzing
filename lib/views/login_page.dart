import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    controller.clearForm();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 150,
            right: -200,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.cyanAccent, Colors.transparent],
                      radius: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -400,
            left: -400,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: 700,
                  height: 700,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.purpleAccent, Colors.transparent],
                      radius: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: -100,
            left: -250,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.lightGreenAccent, Colors.transparent],
                      radius: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                Image.asset("assets/images/language-hiragana.png"),
                SizedBox(
                  width: 2,
                ),
                Text('English',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                Text('Login to your vikn account',
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 18),
                Container(
                  width: 358,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C3347).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset('assets/images/user-2.png',
                                width: 24, height: 24),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: controller.usernameController,
                                style: GoogleFonts.poppins(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: GoogleFonts.poppins(
                                      color: Colors.white54),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Please enter a username';
                                  if (value.length < 3)
                                    return 'At least 3 characters';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(width: 358, height: 1, color: Colors.white24),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Image.asset('assets/images/key-round.png',
                                width: 24, height: 24),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: controller.passwordController,
                                obscureText: true,
                                style: GoogleFonts.poppins(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.poppins(
                                      color: Colors.white54),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Please enter a password';
                                  if (value.length < 6)
                                    return 'Minimum 6 characters';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Forgotten Password?',
                    style:
                        GoogleFonts.poppins(color: Colors.blue, fontSize: 14)),
                const SizedBox(height: 20),
                Obx(() => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Sign in',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16)),
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                child: Text(
                  "Signup Now",
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
