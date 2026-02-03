import 'package:crafty_bay/features/auth/data/models/verify_otp_request_model.dart';
import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';

class OtpVerificationController extends GetxController {
  bool _verifyOtpInProgress = false;
  bool get inProgress => _verifyOtpInProgress;

  Future<bool> verifyOtp(VerifyOtpRequestModel model) async {
    _verifyOtpInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.verifyOtpUrl, body: model.toJson());

    _verifyOtpInProgress = false;
    update();

    if (response.success) {
      return true;
    } else {
      showSnackBarMessage(
        'OTP Verification Failed',
        response.errorMessage,
        isError: true,
      );
      return false;
    }
  }
}
