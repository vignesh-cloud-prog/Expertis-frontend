class ShopListModel {
  List<ShopModel>? shops;

  ShopListModel({this.shops});

  ShopListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shops = <ShopModel>[];
      json['data'].forEach((v) {
        shops!.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopModel {
  List<String>? likes;
  String? owner;
  String? shopId;
  String? shopName;
  String? shopLogo;
  Contact? contact;
  WorkingHours? workingHours;
  List<String>? tags;
  List<Members>? members;
  bool? isVerifiedByAdmin;
  List<Services>? services;
  List<String>? appointments;
  List<String>? slotsBooked;
  Rating? rating;
  List<String>? reviews;
  bool? isDeleted;
  bool? isActive;
  bool? isOpen;
  String? createdAt;
  String? updatedAt;
  String? id;

  ShopModel(
      {this.likes,
      this.owner,
      this.shopId,
      this.shopName,
      this.shopLogo,
      this.contact,
      this.workingHours,
      this.tags,
      this.members,
      this.isVerifiedByAdmin,
      this.services,
      this.appointments,
      this.slotsBooked,
      this.rating,
      this.reviews,
      this.isDeleted,
      this.isActive,
      this.isOpen,
      this.createdAt,
      this.updatedAt,
      this.id});

  ShopModel.fromJson(Map<String, dynamic> json) {
    likes = json['likes'].cast<String>();
    owner = json['owner'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    shopLogo = json['shopLogo'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    workingHours = json['workingHours'] != null
        ? new WorkingHours.fromJson(json['workingHours'])
        : null;
    tags = json['tags'].cast<String>();
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['owner'] = this.owner;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['shopLogo'] = this.shopLogo;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.workingHours != null) {
      data['workingHours'] = this.workingHours!.toJson();
    }
    data['tags'] = this.tags;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
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

class WorkingHours {
  Sunday? sunday;
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Sunday? saturday;
  String? id;

  WorkingHours(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.id});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    sunday =
        json['sunday'] != null ? new Sunday.fromJson(json['sunday']) : null;
    monday =
        json['monday'] != null ? new Sunday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Sunday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Sunday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Sunday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Sunday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Sunday.fromJson(json['saturday']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Sunday {
  bool? isOpen;
  String? openingTime;
  String? closingTime;
  List<Breaks>? breaks;
  String? id;

  Sunday(
      {this.isOpen, this.openingTime, this.closingTime, this.breaks, this.id});

  Sunday.fromJson(Map<String, dynamic> json) {
    isOpen = json['isOpen'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(new Breaks.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOpen'] = this.isOpen;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Breaks {
  String? from;
  String? to;
  String? reason;
  String? sId;

  Breaks({this.from, this.to, this.reason, this.sId});

  Breaks.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    reason = json['reason'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['reason'] = this.reason;
    data['_id'] = this.sId;
    return data;
  }
}

class Members {
  String? member;
  String? name;
  String? role;
  String? id;
  String? pic;

  Members({this.member, this.name, this.role, this.id, this.pic});

  Members.fromJson(Map<String, dynamic> json) {
    member = json['member'];
    name = json['name'];
    role = json['role'];
    id = json['id'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member'] = this.member;
    data['name'] = this.name;
    data['role'] = this.role;
    data['id'] = this.id;
    data['pic'] = this.pic;
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
