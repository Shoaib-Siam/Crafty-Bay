import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
// import 'package:crafty_bay/features/auth/presentation/controllers/auth_controller.dart'; // Uncomment when ready

import 'app.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorized: _onUnAuthorized,
    // FIX: Pass a function using () =>
    accessToken: () {
      // TODO: Return your real token here later
      // Example: return AuthController.accessToken ?? '';
      return '';
    },
  );
}

Future<void> _onUnAuthorized() async {
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.routeName,
        (route) => false,
  );
}