class Provinces {
  List<Province>? provinces;

  Provinces({this.provinces});

  Provinces.fromJson(Map<String, dynamic> json) {
    if (json['provinces'] != null) {
      provinces = <Province>[];
      json['provinces'].forEach((v) {
        provinces!.add(new Province.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provinces != null) {
      data['provinces'] = this.provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Province {
  String? code;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? codeName;
  String? unitTitle;
  String? region;

  Province(
      {this.code,
        this.name,
        this.nameEn,
        this.fullName,
        this.fullNameEn,
        this.codeName,
        this.unitTitle,
        this.region});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['name'] as String,
      code: json['code'] as String,
      nameEn: json['nameEn'] as String,
      fullName: json['fullName'] as String,
      fullNameEn: json['fullNameEn'] as String,
      codeName: json['codeName'] as String,
      unitTitle: json['unitTitle'] as String,
      region: json['region'] as String,
    );
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
    data['region'] = this.region;
    return data;
  }
}