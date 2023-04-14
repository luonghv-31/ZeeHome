import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/post.dart';
import 'package:http/http.dart' as http;

const String url = 'https://huydt.online/api/houses';

class HouseListRequest {

  static List<House> parseHouseList(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<House> houses = list.map((model) => House.fromJson(model)).toList();
    return houses;
  }

  static Future<List<House>> fetchHouseList({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute( parseHouseList, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}