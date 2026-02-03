import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/reset_password_request_model.dart';

class ResetPasswordController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  Future<bool> resetPassword(ResetPasswordRequestModel model) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.resetPasswordUrl, body: model.toJson());

    _inProgress = false;
    update();

    if (response.success) {
      return true;
    } else {
      showSnackBarMessage(
        'Reset Password Failed',
        response.errorMessage,
        isError: true,
      );
      return false;
    }
  }
}