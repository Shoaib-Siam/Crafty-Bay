import 'package:crafty_bay/app/set_up_network_client.dart';
import 'package:get/get.dart';

import '../features/auth/presentations/controllers/otp_verification_controller.dart';
import '../features/auth/presentations/controllers/sign_in_controller.dart';
import '../features/auth/presentations/controllers/sign_up_controller.dart';
import '../features/shared/presentation/controller/main_nav_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/language_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
    //Get.put(LanguageController());
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(OtpVerificationController());
    // Get.put(EmailVerificationController());
    // Get.put(ResetPasswordController());
  }
}
