import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/auth.dart';
import 'dart:developer' as developer;

const String url = 'https://huydt.online/auth/realms/nhatrotot/protocol/openid-connect/token';

class SignInRequest {

  static Auth parseAuth(String responseBody) {
    var response = json.decode(responseBody);
    Auth auth = Auth.fromJson(response);
    return auth;
  }

  static Future<Auth> fetchAuth(String username, String password) async {

    final response = await http.post(
        Uri.parse(url),
        headers: <String, String> {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          'username': username,
          'password': password,
          'client_id': 'backend',
          'grant_type': 'password',
          'client_secret': '11UJJdC8M4fx3C7YzdlD2X9ruVcC9W3j',
        },
    ).timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        throw Exception('Some error happen'); // Request Timeout response status code
      },
    );
    if (response.statusCode == 200) {
      // developer.log(response.body);
      return compute( parseAuth, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}
