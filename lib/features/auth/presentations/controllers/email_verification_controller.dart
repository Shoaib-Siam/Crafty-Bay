import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;

  Future<bool> verifyEmail(String email) async {
    _inProgress = true;
    update();

    // API usually expects: /UserLogin/VerifyEmail/{email}
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: '${Urls.verifyEmailUrl}/$email');

    _inProgress = false;
    update();

    if (response.success) {
      return true;
    } else {
      showSnackBarMessage(
        'Verification Failed',
        response.errorMessage,
        isError: true,
      );
      return false;
    }
  }
}