class Wards {
  List<Ward>? ward;

  Wards({this.ward});

  Wards.fromJson(Map<String, dynamic> json) {
    if (json['ward'] != null) {
      ward = <Ward>[];
      json['ward'].forEach((v) {
        ward!.add(new Ward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ward != null) {
      data['ward'] = this.ward!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ward {
  String? code;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? codeName;
  String? unitTitle;
  String? district;
  String? districtCode;

  Ward(
      {this.code,
        this.name,
        this.nameEn,
        this.fullName,
        this.fullNameEn,
        this.codeName,
        this.unitTitle,
        this.district,
        this.districtCode});

  Ward.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nameEn = json['nameEn'];
    fullName = json['fullName'];
    fullNameEn = json['fullNameEn'];
    codeName = json['codeName'];
    unitTitle = json['unitTitle'];
    district = json['district'];
    districtCode = json['districtCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['nameEn'] = this.nameEn;
    data['fullName'] = this.fullName;
    data['fullNameEn'] = this.fullNameEn;
    data['codeName'] = this.codeName;
    data['unitTitle'] = this.unitTitle;
    data['district'] = this.district;
    data['districtCode'] = this.districtCode;
    return data;
  }
}