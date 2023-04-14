class House {
  double? latitude;
  double? longitude;
  String? title;
  String? createdDate;
  String? address;
  String? ward;
  String? district;
  String? province;
  int? houseCategory;
  int? houseType;
  String? thumbnail;
  List<String>? images;
  double? price;
  String? video;
  bool? visible;
  double? square;
  String? description;
  bool? ac;
  bool? parking;
  bool? elevator;
  bool? pet;
  int? rooms;
  int? bathRooms;
  int? bedRooms;
  double? maintenanceFee;
  bool? furnished;
  Owner? owner;

  House(
      {this.latitude,
        this.longitude,
        this.title,
        this.createdDate,
        this.address,
        this.ward,
        this.district,
        this.province,
        this.houseCategory,
        this.houseType,
        this.thumbnail,
        this.images,
        this.price,
        this.video,
        this.visible,
        this.square,
        this.description,
        this.ac,
        this.parking,
        this.elevator,
        this.pet,
        this.rooms,
        this.bathRooms,
        this.bedRooms,
        this.maintenanceFee,
        this.furnished,
        this.owner});

  House.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    title = json['title'];
    createdDate = json['createdDate'];
    address = json['address'];
    ward = json['ward'];
    district = json['district'];
    province = json['province'];
    houseCategory = json['houseCategory'];
    houseType = json['houseType'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
    price = json['price'];
    video = json['video'];
    visible = json['visible'];
    square = json['square'];
    description = json['description'];
    ac = json['ac'];
    parking = json['parking'];
    elevator = json['elevator'];
    pet = json['pet'];
    rooms = json['rooms'];
    bathRooms = json['bathRooms'];
    bedRooms = json['bedRooms'];
    maintenanceFee = json['maintenanceFee'];
    furnished = json['furnished'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['title'] = this.title;
    data['createdDate'] = this.createdDate;
    data['address'] = this.address;
    data['ward'] = this.ward;
    data['district'] = this.district;
    data['province'] = this.province;
    data['houseCategory'] = this.houseCategory;
    data['houseType'] = this.houseType;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    data['price'] = this.price;
    data['video'] = this.video;
    data['visible'] = this.visible;
    data['square'] = this.square;
    data['description'] = this.description;
    data['ac'] = this.ac;
    data['parking'] = this.parking;
    data['elevator'] = this.elevator;
    data['pet'] = this.pet;
    data['rooms'] = this.rooms;
    data['bathRooms'] = this.bathRooms;
    data['bedRooms'] = this.bedRooms;
    data['maintenanceFee'] = this.maintenanceFee;
    data['furnished'] = this.furnished;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? email;
  String? userId;
  String? userImage;
  double? userRating;
  String? lastName;
  String? firstName;
  String? phoneNumber;

  Owner(
      {this.email,
        this.userId,
        this.userImage,
        this.userRating,
        this.lastName,
        this.firstName,
        this.phoneNumber});

  Owner.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['userId'];
    userImage = json['userImage'];
    userRating = json['userRating'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['userImage'] = this.userImage;
    data['userRating'] = this.userRating;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}