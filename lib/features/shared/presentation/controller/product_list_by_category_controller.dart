import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/product_model.dart';

class ProductListByCategoryController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<ProductModel> _productList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<ProductModel> get productList => _productList;

  Future<bool> getProductListByCategory(String categoryId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListUrl(categoryId: categoryId),
    );

    if (response.success) {
      ProductListModel model = ProductListModel.fromJson(response.body);
      _productList = model.productList ?? [];
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to fetch products';
      _inProgress = false;
      update();
      return false;
    }
  }
}