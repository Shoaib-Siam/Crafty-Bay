class CategoryListModel {
  String? msg;
  List<CategoryModel>? categoryList;

  CategoryListModel({this.msg, this.categoryList});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];

    // Navigate into data -> results to get the actual list
    if (json['data'] != null && json['data']['results'] != null) {
      categoryList = <CategoryModel>[];
      json['data']['results'].forEach((v) {
        categoryList!.add(CategoryModel.fromJson(v));
      });
    }
  }
}

class CategoryModel {
  String? sId;
  String? title;
  String? icon;

  CategoryModel({this.sId, this.title, this.icon});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    icon = json['icon'];
  }
}