class ProductListModel {
  String? msg;
  List<ProductModel>? productList;

  ProductListModel({this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null && json['data']['results'] != null) {
      productList = <ProductModel>[];
      json['data']['results'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  String? sId;
  String? title;
  Brand? brand;
  List<ProductCategory>? categories;
  String? slug;
  String? description;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  List<String>? tags;
  num? regularPrice; // Using num to safely handle both int and double
  num? currentPrice;
  int? quantity;
  bool? inCart;
  bool? inWishlist;

  ProductModel({
    this.sId,
    this.title,
    this.brand,
    this.categories,
    this.slug,
    this.description,
    this.photos,
    this.colors,
    this.sizes,
    this.tags,
    this.regularPrice,
    this.currentPrice,
    this.quantity,
    this.inCart,
    this.inWishlist,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;

    if (json['categories'] != null) {
      categories = <ProductCategory>[];
      json['categories'].forEach((v) {
        categories!.add(ProductCategory.fromJson(v));
      });
    }

    slug = json['slug'];
    description = json['description'];

    // Safely casting dynamic lists to List<String>
    photos = json['photos']?.cast<String>();
    colors = json['colors']?.cast<String>();
    sizes = json['sizes']?.cast<String>();
    tags = json['tags']?.cast<String>();

    regularPrice = json['regular_price'];
    currentPrice = json['current_price'];
    quantity = json['quantity'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
  }
}

// Simple nested class for the Brand object inside the product
class Brand {
  String? sId;
  String? title;
  String? slug;
  String? icon;

  Brand({this.sId, this.title, this.slug, this.icon});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
  }
}

// Simple nested class for Categories attached to the product
class ProductCategory {
  String? sId;
  String? title;
  String? slug;
  String? icon;

  ProductCategory({this.sId, this.title, this.slug, this.icon});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
  }
}