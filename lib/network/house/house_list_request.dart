import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/houses/houseList.dart';
import 'package:zeehome/model/houses/parameter.dart';

class HouseListRequest {

  static List<House> parseHouseList(String responseBody) {
    var h = json.decode(responseBody) as Map<String, dynamic>;
    final hl = HouseList.fromJson(h).houses?.toList();
    return hl!;
  }

  static Map<String, dynamic> toJson(HouseListParameter houseListParameter) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryFor'] = houseListParameter.queryFor.toString();
    data['queryType'] = houseListParameter.queryType.toString();
    data['distance'] = houseListParameter.distance.toString();
    data['polygonPoints'] = houseListParameter.polygonPoints.toString();
    data['mapPoint'] = houseListParameter.toString();
    data['showInvisible'] = houseListParameter.showInvisible.toString();
    data['pageSize'] = houseListParameter.pageSize.toString();
    data['pageNumber'] = houseListParameter.pageNumber.toString();

    data['roomGte'] = houseListParameter.roomGte.toString();
    data['bedRoomGte'] = houseListParameter.bedRoomGte.toString();
    data['bathRoomGte'] = houseListParameter.bathRoomGte.toString();
    data['priceFrom'] = houseListParameter.priceFrom.toString();
    data['priceTo'] = houseListParameter.priceTo.toString();
    data['hasAc'] = houseListParameter.hasAc.toString();
    data['hasParking'] = houseListParameter.hasParking.toString();
    data['hasElevator'] = houseListParameter.hasElevator.toString();
    data['hasFurnished'] = houseListParameter.hasFurnished.toString();
    data['allowPet'] = houseListParameter.allowPet.toString();
    data['houseCategory'] = houseListParameter.houseCategory.toString();
    data['houseType'] = houseListParameter.houseType.toString();
    return data;
  }

  static Future<List<House>> fetchHouseList(HouseListParameter houseListParameter) async {

    final uri = Uri.https('huydt.online', '/api/houses', {
      "distance": houseListParameter.distance.toString(),
      "queryFor": houseListParameter.queryFor,
      "queryType": houseListParameter.queryType,
      "houseCategory": houseListParameter.houseCategory != null ? houseListParameter.houseCategory.toString() : null,
      "houseType": houseListParameter.houseType != null ? houseListParameter.houseType.toString() : null,
      'priceFrom': houseListParameter.priceFrom != null ? houseListParameter.priceFrom.toString() : null,
      'priceTo': houseListParameter.priceTo != null ? houseListParameter.priceTo.toString() : null,
      'bedRoomGte': houseListParameter.bedRoomGte != null ? houseListParameter.bedRoomGte.toString() : null,
      'bathRoomGte': houseListParameter.bathRoomGte != null ? houseListParameter.bathRoomGte.toString() : null,
      "mapPoint": houseListParameter.mapPoint,
    });
    final response = await http.get(uri);

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return compute( parseHouseList, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      print(response.statusCode);
     throw Exception('Can\'t not get posts');
      
      
    }
  }
}