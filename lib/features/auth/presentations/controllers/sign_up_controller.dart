import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_up_request_model.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get inProgress => _signUpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpRequestModel model) async {
    _signUpInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.signUpUrl, body: model.toJson());

    _signUpInProgress = false;
    update();

    if (response.success) {
      return true;
    } else {
      // If API returns "Email already registered", the user will see that exact text.
      showSnackBarMessage(
        'Sign Up Failed',
        response.errorMessage ?? 'Registration failed',
        isError: true,
      );
      return false;
    }
  }
}