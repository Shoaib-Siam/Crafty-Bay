import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/product_model.dart';

class ProductController extends GetxController {
  // Loading states
  bool _popularInProgress = false;
  bool _specialInProgress = false;
  bool _newInProgress = false;

  // Product Lists
  List<ProductModel> _popularProductList = [];
  List<ProductModel> _specialProductList = [];
  List<ProductModel> _newProductList = [];

  // Error Messages
  String? _popularErrorMessage;
  String? _specialErrorMessage;
  String? _newErrorMessage;

  // Getters
  bool get popularInProgress => _popularInProgress;
  bool get specialInProgress => _specialInProgress;
  bool get newInProgress => _newInProgress;

  List<ProductModel> get popularProductList => _popularProductList;
  List<ProductModel> get specialProductList => _specialProductList;
  List<ProductModel> get newProductList => _newProductList;

  String? get popularErrorMessage => _popularErrorMessage;
  String? get specialErrorMessage => _specialErrorMessage;
  String? get newErrorMessage => _newErrorMessage;

  // Fetch Popular Products
  Future<bool> getPopularProducts() async {
    _popularInProgress = true;
    update();
    bool isSuccess = await _fetchProducts(
      'popular',
      (productList) {
        _popularProductList = productList;
      },
      (error) {
        _popularErrorMessage = error;
      },
    );
    _popularInProgress = false;
    update();
    return isSuccess;
  }

  // Fetch Special Products
  Future<bool> getSpecialProducts() async {
    _specialInProgress = true;
    update();
    bool isSuccess = await _fetchProducts(
      'special',
      (productList) {
        _specialProductList = productList;
      },
      (error) {
        _specialErrorMessage = error;
      },
    );
    _specialInProgress = false;
    update();
    return isSuccess;
  }

  // Fetch New Products
  Future<bool> getNewProducts() async {
    _newInProgress = true;
    update();
    bool isSuccess = await _fetchProducts(
      'new',
      (productList) {
        _newProductList = productList;
      },
      (error) {
        _newErrorMessage = error;
      },
    );
    _newInProgress = false;
    update();
    return isSuccess;
  }

  // Private helper method to keep the code clean (DRY principle)
  Future<bool> _fetchProducts(
    String tag,
    Function(List<ProductModel>) onSuccess,
    Function(String) onError,
  ) async {
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListUrl(tag: tag),
    );

    if (response.success) {
      ProductListModel model = ProductListModel.fromJson(response.body);
      onSuccess(model.productList ?? []);
      return true;
    } else {
      onError(response.errorMessage ?? 'Failed to fetch $tag products');
      return false;
    }
  }
}
