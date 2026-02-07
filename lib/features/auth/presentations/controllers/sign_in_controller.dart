import 'package:get/get.dart';
import '../../../../app/controller/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_in_request_model.dart';

class SignInController extends GetxController {
  bool _signInInProgress = false;
  bool get inProgress => _signInInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInRequestModel model) async {
    _signInInProgress = true;
    update();

    // 1. Call Login API
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
          url: Urls.signInUrl,
          body: model.toJson(),
          isFromLogin: true,
        );

    if (response.success) {
      // 2. Extract Token
      final String token =
          response.body['token'] ?? response.body['data']['token'];

      // 3. Save Token immediately so NetworkCaller works
      await AuthController.saveUserToken(token);

      // 4. Now call the profile API
      final result = await Get.find<NetworkCaller>().getRequest(
        url: Urls.readProfileUrl,
      );

      if (result.success && result.body['data'] != null) {
        UserModel user = UserModel.fromJson(result.body['data']);

        // 5. Update AuthController with full details
        await AuthController.saveUserParams(token, user);

        _signInInProgress = false;
        update();
        return true; // ✅ Success Path
      } else {
        _errorMessage = "Failed to load user profile.";
        showSnackBarMessage('Error', _errorMessage!, isError: true);

        _signInInProgress = false;
        update();
        return false;
      }
    } else {
      _errorMessage = response.errorMessage;
      showSnackBarMessage('Login Failed', _errorMessage!, isError: true);

      _signInInProgress = false;
      update();
      return false;
    }
  }
}
