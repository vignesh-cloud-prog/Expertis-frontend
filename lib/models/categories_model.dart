class CategoryListModel {
  List<CategoryModel>? categories;

  CategoryListModel({this.categories});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <CategoryModel>[];
      json['data'].forEach((v) {
        print("v is ${v.toString()}");
        categories!.add(new CategoryModel.fromJson(v));
      });
      print("category list is ${categories.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? tagName;
  String? tagPic;
  String? isVerifiedByAdmin;
  List<String>? shops;
  List<String>? services;
  String? id;

  CategoryModel(
      {this.tagName,
      this.tagPic,
      this.isVerifiedByAdmin,
      this.shops,
      this.services,
      this.id});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    tagName = json['tagName'];
    tagPic = json['tagPic'];
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    shops = json['shops'].cast<String>();
    services = json['services'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagName'] = this.tagName;
    data['tagPic'] = this.tagPic;
    data['isVerifiedByAdmin'] = this.isVerifiedByAdmin;
    data['shops'] = this.shops;
    data['services'] = this.services;
    data['id'] = this.id;
    return data;
  }
}
