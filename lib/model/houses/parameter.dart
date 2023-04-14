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
    data['queryFor'] = this.queryFor;
    data['queryType'] = this.queryType;
    data['distance'] = this.distance;
    data['polygonPoints'] = this.polygonPoints;
    data['mapPoint'] = this.mapPoint;
    data['showInvisible'] = this.showInvisible;
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    data['houseType'] = this.houseType;
    return data;
  }
}