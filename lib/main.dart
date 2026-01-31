import 'dart:ui';
import 'package:crafty_bay/app/utils/app_version_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <--- 1. ADD THIS IMPORT

import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. ADD THIS BLOCK (Makes status bar transparent)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent background
    statusBarIconBrightness: Brightness.dark, // Dark icons for white background
    statusBarBrightness: Brightness.light, // iOS Status Bar setting
  ));

  // Firebase Setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await AppVersionService.getCurrentAppVersion();

  runApp(const CraftyBay());
}