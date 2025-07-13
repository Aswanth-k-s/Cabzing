import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/secure_storage_service.dart';
import '../views/login_page.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  ProfilePage({required this.userInfo, super.key}) {
    final controller = Get.put(ProfileController());
    controller.setUserInfo(userInfo);
  }

  final SecureStorageService _storage = SecureStorageService();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(() => CircleAvatar(
                            radius: 30,
                            backgroundImage: controller
                                    .profileImage.value.isNotEmpty
                                ? NetworkImage(controller.profileImage.value)
                                : const AssetImage('assets/images/profile.png')
                                    as ImageProvider,
                          )),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.username.value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(controller.email.value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.grey)),
                              ],
                            )),
                      ),
                      const Icon(Icons.edit, color: Colors.white70),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildStatBox('4.3★', '2,211 rides'),
                      const SizedBox(width: 16),
                      _buildStatBox('KYC', 'Verified'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await _storage.clearAll();
                      Get.offAll(() => const LoginPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(Icons.help_outline, 'Help'),
                  _buildListTile(Icons.question_answer_outlined, 'FAQ'),
                  _buildListTile(Icons.group_add_outlined, 'Invite Friends'),
                  _buildListTile(
                      Icons.description_outlined, 'Terms of service'),
                  _buildListTile(Icons.privacy_tip_outlined, 'Privacy Policy'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: GoogleFonts.poppins(color: Colors.white)),
            Text(subtitle,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: GoogleFonts.poppins(color: Colors.white)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {},
    );
  }
}
