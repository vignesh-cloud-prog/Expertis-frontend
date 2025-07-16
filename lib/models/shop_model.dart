class ShopModel {
  String? owner;
  String? shopId;
  String? shopLogo;
  String? shopName;
  String? about;
  String? gender;
  Contact? contact;
  WorkingHours? workingHours;
  List<String>? likes;
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
      {this.owner,
      this.shopId,
      this.shopLogo,
      this.shopName,
      this.about,
      this.gender,
      this.contact,
      this.workingHours,
      this.likes,
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
    owner = json['owner'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    shopLogo = json['shopLogo'];
    if (json['about'] != null) {
      about = json['about'];
    } else {
      about = null;
    }
    gender = json['gender'];
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    workingHours = json['workingHours'] != null
        ? WorkingHours.fromJson(json['workingHours'])
        : null;
    likes = json['likes'] != null ? List<String>.from(json['likes']) : null;
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    appointments = json['appointments'] != null
        ? List<String>.from(json['appointments'])
        : null;
    slotsBooked = json['slotsBooked'] != null
        ? List<String>.from(json['slotsBooked'])
        : null;
    rating =
        json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    reviews =
        json['reviews'] != null ? List<String>.from(json['reviews']) : null;
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    isOpen = json['isOpen'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['shopId'] = shopId;
    data['shopName'] = shopName;
    data['shopLogo'] = shopLogo;
    data['about'] = about;
    data['gender'] = gender;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (workingHours != null) {
      data['workingHours'] = workingHours!.toJson();
    }
    data['likes'] = likes;
    data['tags'] = tags;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['isVerifiedByAdmin'] = isVerifiedByAdmin;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['appointments'] = appointments;
    data['slotsBooked'] = slotsBooked;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['reviews'] = reviews;
    data['isDeleted'] = isDeleted;
    data['isActive'] = isActive;
    data['isOpen'] = isOpen;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class Contact {
  String? email;
  int? phone;
  String? address;
  int? pinCode;
  String? id;
  String? whatsapp;
  String? facebook;
  String? instagram;
  String? twitter;
  String? website;

  Contact(
      {this.email,
      this.phone,
      this.address,
      this.pinCode,
      this.id,
      this.whatsapp,
      this.facebook,
      this.instagram,
      this.twitter,
      this.website});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    pinCode = json['pinCode'];
    id = json['id'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['pinCode'] = pinCode;
    data['id'] = id;
    data['whatsapp'] = whatsapp;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['website'] = website;

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
        json['sunday'] != null ? Sunday.fromJson(json['sunday']) : null;
    monday =
        json['monday'] != null ? Sunday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? Sunday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? Sunday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? Sunday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? Sunday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? Sunday.fromJson(json['saturday']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sunday != null) {
      data['sunday'] = sunday!.toJson();
    }
    if (monday != null) {
      data['monday'] = monday!.toJson();
    }
    if (tuesday != null) {
      data['tuesday'] = tuesday!.toJson();
    }
    if (wednesday != null) {
      data['wednesday'] = wednesday!.toJson();
    }
    if (thursday != null) {
      data['thursday'] = thursday!.toJson();
    }
    if (friday != null) {
      data['friday'] = friday!.toJson();
    }
    if (saturday != null) {
      data['saturday'] = saturday!.toJson();
    }
    data['id'] = id;
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
        breaks!.add(Breaks.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isOpen'] = isOpen;
    data['openingTime'] = openingTime;
    data['closingTime'] = closingTime;
    if (breaks != null) {
      data['breaks'] = breaks!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['reason'] = reason;
    data['_id'] = sId;
    return data;
  }
}

class Members {
  String? member;
  String? name;
  String? role;
  String? id;
  String? pic;

  Members({this.member, this.name, this.role, this.id});

  Members.fromJson(Map<String, dynamic> json) {
    member = json['member'];
    name = json['name'];
    role = json['role'];
    id = json['id'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member'] = member;
    data['name'] = name;
    data['role'] = role;
    data['id'] = id;
    data['pic'] = pic;
    return data;
  }
}

class Services {
  // String? shop;
  String? serviceName;
  int? price;
  String? time;
  String? isVerifiedByAdmin;
  String? shop;
  List<String>? tags;
  String? id;
  String? photo;
  String? description;

  Services({
    this.serviceName,
    this.price,
    this.time,
    this.isVerifiedByAdmin,
    this.shop,
    this.tags,
    this.id,
    this.photo,
    this.description,
  });

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    price = json['price'];
    time = json['time'];
    isVerifiedByAdmin = json['isVerifiedByAdmin'];
    shop = json['shop'];
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    id = json['id'];
    photo = json['photo'];
    description = json['description'];
    // shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceName'] = serviceName;
    data['price'] = price;
    data['time'] = time;
    data['isVerifiedByAdmin'] = isVerifiedByAdmin;
    data['shop'] = shop;
    data['tags'] = tags;
    data['id'] = id;
    data['photo'] = photo;
    data['description'] = description;
    // data['shopId'] = this.shopId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg'] = avg;
    data['oneStar'] = oneStar;
    data['twoStar'] = twoStar;
    data['threeStar'] = threeStar;
    data['fourStar'] = fourStar;
    data['fiveStar'] = fiveStar;
    data['totalMembers'] = totalMembers;
    data['_id'] = sId;
    return data;
  }
}
