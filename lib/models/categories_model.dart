class CategoryListModel {
  List<CategoryModel>? categories;

  CategoryListModel({this.categories});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <CategoryModel>[];
      json['data'].forEach((v) {
        // print("v is ${v.toString()}");
        categories!.add(CategoryModel.fromJson(v));
      });
      // print("category list is ${categories.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? tagName;
  String? tagPic;
  String? description;
  String? isVerifiedByAdmin;
  List<String>? shops;
  List<String>? services;
  String? id;

  CategoryModel(
      {this.tagName,
      this.tagPic,
      this.description,
      this.isVerifiedByAdmin,
      this.shops,
      this.services,
      this.id});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    tagName = json['tagName'];
    tagPic = json['tagPic'];
    description = json['description'];
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    shops = json['shops'] != null ? List<String>.from(json['shops']) : null;
    services =
        json['services'] != null ? List<String>.from(json['services']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tagName'] = tagName;
    data['tagPic'] = tagPic;
    data['description'] = description;
    data['isVerifiedByAdmin'] = isVerifiedByAdmin;
    data['shops'] = shops;
    data['services'] = services;
    data['id'] = id;
    return data;
  }
}
