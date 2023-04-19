import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/country/wardList.dart';

const String url = 'https://huydt.online/api/users/me/my-info';

class GetListDistrict {
  static Wards parseWards(String responseBody) {
    var response = json.decode(responseBody);
    Wards wards = Wards.fromJson(response);
    return wards;
  }

  static Future<Wards> fetch(String access_token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      // developer.log(response.body);
      return compute( parseWards, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}