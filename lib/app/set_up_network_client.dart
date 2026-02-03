import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'controller/auth_controller.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorized: _onUnAuthorized,
    // FIX: Pass a function using () =>
    accessToken: () => AuthController.accessToken,
  );
}

Future<void> _onUnAuthorized() async {
  // If 401 happens, clear data and force logout
  await AuthController.clearAuthData();
}