import 'package:get/get.dart';
import '../../../../../app/urls.dart';
import '../../../../../core/models/network_response.dart';
import '../../../../../core/services/network_caller.dart';
import '../data/models/slider_model.dart';

class SliderController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<SliderModel> _sliderList = [];

  // Getters for the UI to read
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<SliderModel> get sliderList => _sliderList;

  Future<bool> getSliders() async {
    _inProgress = true;
    update();

    // Make the API call
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.slideListUrl,
    );

    bool isSuccess = false;

    if (response.success) {
      SliderListModel sliderListModel = SliderListModel.fromJson(response.body);
      _sliderList = sliderListModel.sliderList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
