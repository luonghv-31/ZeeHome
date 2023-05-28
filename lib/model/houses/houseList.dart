import 'package:flutter/material.dart';
import 'package:zeehome/model/houses/house.dart';

class HouseList {
  List<House>? houses;

  HouseList({this.houses});

  HouseList.fromJson(Map<String, dynamic> json) {
    if (json['houses'] != null) {
      houses = <House>[];
      json['houses'].forEach((v) {
        houses!.add(House.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.houses != null) {
      data['houses'] = this.houses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}