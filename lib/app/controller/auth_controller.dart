import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../features/auth/presentations/screens/sign_in_screen.dart';

class AuthController extends GetxController {
  static String? _accessToken;

  // 1. Getter for the token (used by NetworkCaller)
  static String get accessToken => _accessToken ?? '';

  // 2. Check if user is logged in
  static bool get isLoggedIn =>
      _accessToken != null && _accessToken!.isNotEmpty;

  // 3. Save User Data (Call this after Login/Signup success)
  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    _accessToken = token;
  }

  // 4. Read User Data (Call this on App Startup/Splash Screen)
  static Future<void> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('token');
  }

  // 5. Logout (Clear data and move to Login)
  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _accessToken = null;

    // Navigate to Login and remove all previous routes
    Get.offAllNamed(SignInScreen.routeName);
  }
}
