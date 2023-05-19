import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/houses/house.dart';

const String url = 'https://huydt.online/api/houses';

class GetHouseDetailRequest {

  static House parseHouse(String responseBody) {
    var response = json.decode(responseBody);
    House house = House.fromJson(response);
    return house;
  }
  static Future<House> fetchHouseDetail(String houseId) async {
    final response = await http.get(
      Uri.parse('$url/$houseId'),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return compute( parseHouse, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}