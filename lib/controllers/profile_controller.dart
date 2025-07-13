import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = 'Unknown User'.obs;
  var email = 'No Email'.obs;
  var profileImage = ''.obs;

  void setUserInfo(Map<String, dynamic> userInfo) {
    username.value = userInfo['username'] ?? 'Unknown User';
    email.value = userInfo['email'] ?? 'No Email';
    profileImage.value = userInfo['profile_image'] ?? '';
  }
}
