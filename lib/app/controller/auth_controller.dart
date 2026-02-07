import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../features/auth/presentations/screens/sign_in_screen.dart';
import '../../features/shared/data/models/user_model.dart';

class AuthController extends GetxController {
  static String? _accessToken;
  static UserModel? _userData;

  static String get accessToken => _accessToken ?? '';
  static UserModel? get userData => _userData;

  static bool get isLoggedIn =>
      _accessToken != null && _accessToken!.isNotEmpty;

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    _accessToken = token;
  }

  // Save Both Token and Data
  static Future<void> saveUserParams(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Save Token
    await sharedPreferences.setString('token', token);
    _accessToken = token;

    // Save User Data
    await sharedPreferences.setString('userData', jsonEncode(model.toJson()));
    _userData = model;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _accessToken = sharedPreferences.getString('token');

    String? userResult = sharedPreferences.getString('userData');
    if (userResult != null) {
      _userData = UserModel.fromJson(jsonDecode(userResult));
    }
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _accessToken = null;
    _userData = null;
    Get.offAllNamed(SignInScreen.routeName);
  }
}
