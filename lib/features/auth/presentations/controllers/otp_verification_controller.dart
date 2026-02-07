import 'package:crafty_bay/features/auth/data/models/verify_otp_request_model.dart';
import 'package:get/get.dart';
import '../../../../app/controller/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
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
      // 1. Extract Token and User Data from the correct path
      final String token = response.body['data']['token'];
      final Map<String, dynamic> userDataMap = response.body['data']['user'];

      // 2. Create Model
      UserModel user = UserModel.fromJson(userDataMap);

      // 3. Save to Storage
      await AuthController.saveUserParams(token, user);

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
