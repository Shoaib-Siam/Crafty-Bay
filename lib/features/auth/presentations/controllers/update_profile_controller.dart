import 'package:get/get.dart';
import '../../../../app/controller/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/update_profile_request_model.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(UpdateProfileRequestModel model) async {
    _inProgress = true;
    update();

    // API Call: Using PATCH as per your API requirement
    final NetworkResponse
    response = await Get.find<NetworkCaller>().patchRequest(
      url: Urls
          .updateProfileUrl, // Ensure this URL is defined in your Urls class
      body: model.toJson(),
    );

    _inProgress = false;
    update();

    if (response.success) {
      // CRITICAL: Update the local user data immediately
      // This ensures the App Drawer / Profile Screen shows the new name without restarting the app
      _updateLocalUserData(model);

      return true;
    } else {
      _errorMessage = response.errorMessage;
      showSnackBarMessage(
        'Update Failed',
        _errorMessage ?? 'Something went wrong',
        isError: true,
      );
      return false;
    }
  }

  void _updateLocalUserData(UpdateProfileRequestModel model) {
    // 1. Get the current user data
    UserModel? currentUser = AuthController.userData;

    if (currentUser != null) {
      // 2. Overwrite with new values
      currentUser.firstName = model.firstName;
      currentUser.lastName = model.lastName;
      currentUser.phone = model.phone;
      currentUser.city = model.city;

      // 3. Save back to storage
      AuthController.saveUserParams(AuthController.accessToken, currentUser);

      // 4. Force UI update if AuthController is being listened to elsewhere
      Get.find<AuthController>().update();
    }
  }
}
