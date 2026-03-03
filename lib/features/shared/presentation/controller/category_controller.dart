import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/category_model.dart';

class CategoryController extends GetxController {
  int _currentPage = 0;
  int? _lastPageNo;
  final int _pageSize = 40;

  bool _getCategoryInProgress = false;
  bool _isInitialLoading = false;
  String? _errorMessage;
  final List<CategoryModel> _categoryList = [];

  bool get getCategoryInProgress => _getCategoryInProgress;
  bool get isInitialLoading => _isInitialLoading;
  String? get errorMessage => _errorMessage;
  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;

    // Prevent fetching if we already reached the last page
    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }

    if (_currentPage == 0) {
      _categoryList.clear();
      _isInitialLoading = true;
    } else {
      _getCategoryInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.categoryListUrl(_currentPage, _pageSize),
    ); // <-- URL updated here

    if (response.success) {
      // Matches your NetworkResponse model
      _lastPageNo = response.body['data']['last_page'];

      List<CategoryModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']['results']) {
        list.add(CategoryModel.fromJson(jsonData));
      }

      _categoryList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getCategoryInProgress = false;
    }

    update();
    return isSuccess;
  }

  Future<void> refreshCategoryList() async {
    _currentPage = 0;
    _lastPageNo = null; // Reset the last page as well
    getCategoryList();
  }
}
