class SliderListModel {
  String? msg;
  List<SliderModel>? sliderList;

  SliderListModel({this.msg, this.sliderList});

  SliderListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];

    // We MUST keep this to navigate into the 'results' array
    if (json['data'] != null && json['data']['results'] != null) {
      sliderList = <SliderModel>[];
      json['data']['results'].forEach((v) {
        sliderList!.add(SliderModel.fromJson(v));
      });
    }
  }
}

class SliderModel {
  String? sId;
  String? photoUrl;
  String? description;
  String? brandId;

  SliderModel({
    this.sId,
    this.photoUrl,
    this.description,
    this.brandId,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photoUrl = json['photo_url'];
    description = json['description'];
    brandId = json['brand'];
  }
}