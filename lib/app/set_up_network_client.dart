import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:crafty_bay/features/auth/presentations/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'app.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(onUnAuthorized: _onUnAuthorized, accessToken: '');
}

Future<void> _onUnAuthorized() async {
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.routeName,
    (route) => false,
  );
}
