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
    await Future.delayed(const Duration(seconds: 2));

    // 1. Check if token exists
    await AuthController.getUserToken();

    // 2. Navigate based on status
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
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                '${context.localization.version} '
                '${AppVersionService.currentAppVersion}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
