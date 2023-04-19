import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/country/provinceList.dart';

const String url = 'https://huydt.online/api/users/me/my-info';

class GetListProvince {
  static Provinces parseProvinces(String responseBody) {
    var response = json.decode(responseBody);
    Provinces provinces = Provinces.fromJson(response);
    return provinces;
  }

  static Future<Provinces> fetch(String access_token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      // developer.log(response.body);
      return compute( parseProvinces, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}