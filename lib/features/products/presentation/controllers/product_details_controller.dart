import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/product_model.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  ProductModel? _product;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  ProductModel? get product => _product;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productDetailsById(productId),
    );

    if (response.success) {
      // Parse the 'data' object directly into our existing ProductModel
      _product = ProductModel.fromJson(response.body['data']);
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to fetch product details';
      _inProgress = false;
      update();
      return false;
    }
  }
}