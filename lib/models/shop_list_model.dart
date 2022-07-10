class ShopListModel {
  List<Shop>? shop;

  ShopListModel({this.shop});

  ShopListModel.fromJson(Map<String, dynamic> json) {
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  String? owner;
  String? shopName;
  String? shopLogo;
  Contact? contact;
  List<String>? tags;
  bool? isVerifiedByAdmin;
  List<Services>? services;
  List<String>? appointments;
  List<String>? slotsBooked;
  Rating? rating;
  List<String>? reviews;
  bool? isDeleted;
  bool? isActive;
  bool? isOpen;
  List<String>? members;
  String? createdAt;
  String? updatedAt;
  String? id;

  Shop(
      {this.owner,
      this.shopName,
      this.shopLogo,
      this.contact,
      this.tags,
      this.isVerifiedByAdmin,
      this.services,
      this.appointments,
      this.slotsBooked,
      this.rating,
      this.reviews,
      this.isDeleted,
      this.isActive,
      this.isOpen,
      this.members,
      this.createdAt,
      this.updatedAt,
      this.id});

  Shop.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    shopName = json['shopName'];
    shopLogo = json['shopLogo'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    tags = json['tags'].cast<String>();
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    appointments = json['appointments'].cast<String>();
    slotsBooked = json['slotsBooked'].cast<String>();
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    reviews = json['reviews'].cast<String>();
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    isOpen = json['isOpen'];
    members = json['members'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['shopName'] = this.shopName;
    data['shopLogo'] = this.shopLogo;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['tags'] = this.tags;
    data['isVerifiedByAdmin'] = this.isVerifiedByAdmin;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['appointments'] = this.appointments;
    data['slotsBooked'] = this.slotsBooked;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['reviews'] = this.reviews;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['isOpen'] = this.isOpen;
    data['members'] = this.members;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Contact {
  String? email;
  int? phone;
  String? address;
  int? pinCode;
  String? id;

  Contact({this.email, this.phone, this.address, this.pinCode, this.id});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    pinCode = json['pinCode'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['pinCode'] = this.pinCode;
    data['id'] = this.id;
    return data;
  }
}

class Services {
  String? serviceName;
  int? price;
  String? time;
  String? isVerifiedByAdmin;
  String? shop;
  List<String>? tags;
  String? id;

  Services(
      {this.serviceName,
      this.price,
      this.time,
      this.isVerifiedByAdmin,
      this.shop,
      this.tags,
      this.id});

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    price = json['price'];
    time = json['time'];
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    shop = json['shop'];
    tags = json['tags'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['price'] = this.price;
    data['time'] = this.time;
    data['isVerifiedByAdmin'] = this.isVerifiedByAdmin;
    data['shop'] = this.shop;
    data['tags'] = this.tags;
    data['id'] = this.id;
    return data;
  }
}

class Rating {
  int? avg;
  int? oneStar;
  int? twoStar;
  int? threeStar;
  int? fourStar;
  int? fiveStar;
  int? totalMembers;
  String? sId;

  Rating(
      {this.avg,
      this.oneStar,
      this.twoStar,
      this.threeStar,
      this.fourStar,
      this.fiveStar,
      this.totalMembers,
      this.sId});

  Rating.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    oneStar = json['oneStar'];
    twoStar = json['twoStar'];
    threeStar = json['threeStar'];
    fourStar = json['fourStar'];
    fiveStar = json['fiveStar'];
    totalMembers = json['totalMembers'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['oneStar'] = this.oneStar;
    data['twoStar'] = this.twoStar;
    data['threeStar'] = this.threeStar;
    data['fourStar'] = this.fourStar;
    data['fiveStar'] = this.fiveStar;
    data['totalMembers'] = this.totalMembers;
    data['_id'] = this.sId;
    return data;
  }
}
