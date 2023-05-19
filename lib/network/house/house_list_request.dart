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

  static Future<List<House>> fetchHouseList(HouseListParameter houseListParameter) async {
    debugPrint(houseListParameter.toString());
    final uri = Uri.https('huydt.online', '/api/houses', houseListParameter.toJson());
    final response = await http.get(uri);

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return compute( parseHouseList, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}