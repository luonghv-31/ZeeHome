import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:zeehome/model/user.dart';

const String url = 'https://huydt.online/api/users/me/my-info';

class GetUserRequest {

  static User parseUser(String responseBody) {
    var response = json.decode(responseBody);
    User user = User.fromJson(response);
    return user;
  }

  static Future<User> fetchUser(String access_token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      // developer.log(response.body);
      print(response.body);
      return compute( parseUser, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}