class HouseListParameter {
  String? queryFor;
  String? queryType;
  double? distance;
  String? polygonPoints;
  String? mapPoint;
  bool? showInvisible;
  int? pageSize;
  int? pageNumber;

  int? roomGte;
  int? bedRoomGte;
  int? bathRoomGte;
  double? priceFrom;
  double? priceTo;
  bool? hasAc;
  bool? hasParking;
  bool? hasElevator;
  bool? hasFurnished;
  bool? allowPet;
  int? houseCategory;
  int? houseType;

  HouseListParameter(
      {this.queryFor,
        this.queryType,
        this.distance,
        this.polygonPoints,
        this.mapPoint,
        this.showInvisible,
        this.pageSize,
        this.pageNumber,
        this.houseType,
        this.houseCategory,
        this.roomGte,
        this.bedRoomGte,
        this.bathRoomGte,
        this.priceFrom,
        this.priceTo,
        this.hasAc,
        this.hasParking,
        this.hasElevator,
        this.hasFurnished,
        this.allowPet,
      });

  HouseListParameter.fromJson(Map<String, dynamic> json) {
    queryFor = json['queryFor'];
    queryType = json['queryType'];
    distance = json['distance'];
    polygonPoints = json['polygonPoints'];
    mapPoint = json['mapPoint'];
    showInvisible = json['showInvisible'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    houseType = json['houseType'];

    roomGte = json['roomGte'];
    bedRoomGte = json['bedRoomGte'];
    bathRoomGte = json['bathRoomGte'];
    priceFrom = json['priceFrom'];
    priceTo = json['priceTo'];
    hasAc = json['hasAc'];
    hasParking = json['hasParking'];
    hasElevator = json['hasElevator'];
    hasFurnished = json['hasFurnished'];
    allowPet = json['allowPet'];
    houseCategory = json['houseCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryFor'] = this.queryFor?.toString();
    data['queryType'] = this.queryType?.toString();
    data['distance'] = this.distance?.toString();
    // polygonPoints != null ? data['polygonPoints'] = this.polygonPoints?.toString() : '';
    data['mapPoint'] = this.mapPoint?.toString();
    data['showInvisible'] = this.showInvisible?.toString();
    data['pageSize'] = this.pageSize?.toString();
    data['pageNumber'] = this.pageNumber?.toString();
    data['houseType'] = this.houseType?.toString();

    data['roomGte'] = this.roomGte;
    data['bedRoomGte'] = this.bedRoomGte;
    data['bathRoomGte'] = this.bathRoomGte;
    data['priceFrom'] = this.priceFrom;
    data['priceTo'] = this.priceTo;
    data['hasAc'] = this.hasAc;
    data['hasParking'] = this.hasParking;
    data['hasElevator'] = this.hasElevator;
    data['hasFurnished'] = this.hasFurnished;
    data['allowPet'] = this.allowPet;
    data['houseCategory'] = this.houseCategory;

    return data;
  }
}