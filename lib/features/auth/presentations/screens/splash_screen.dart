import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/app/utils/app_version_service.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/controller/auth_controller.dart';
import '../../../shared/presentation/screens/bottom_nav_screen.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // 1. Wait for 2 seconds (visual delay)
    await Future.delayed(const Duration(seconds: 2));

    // 2. Load User Data (Token + Profile)
    // Make sure your AuthController has a method named 'getUserData' or 'getUserToken'
    // that loads shared preferences.
    await AuthController.getUserData();

    // 3. Navigate based on status
    if (AuthController.isLoggedIn) {
      Get.offAllNamed(MainBottomNavScreen.routeName);
    } else {
      Get.offAllNamed(SignInScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const AppLogo(),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                '${context.localization.version} '
                    '${AppVersionService.currentAppVersion}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}