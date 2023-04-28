class HouseListParameter {
  String? queryFor;
  String? queryType;
  double? distance;
  String? polygonPoints;
  String? mapPoint;
  bool? showInvisible;
  int? pageSize;
  int? pageNumber;
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
        this.houseType,});

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
    return data;
  }
}