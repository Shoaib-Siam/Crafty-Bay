import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_in_request_model.dart';
// import '../controllers/auth_controller.dart'; // Uncomment when you have AuthController

class SignInController extends GetxController {
  bool _signInInProgress = false;
  bool get inProgress => _signInInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInRequestModel model) async {
    _signInInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
          url: Urls.signInUrl,
          body: model.toJson(),
          isFromLogin: true,
        );

    _signInInProgress = false;
    update();

    if (response.success) {
      // Login Success Logic...
      return true;
    } else {
      showSnackBarMessage(
        'Login Failed',
        response.errorMessage, // Fallback
        isError: true,
      );
      return false;
    }
  }
}
