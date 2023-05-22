import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = 'https://huydt.online/api/users/actions/following';

class DeleteFollowRequest {
  static Future<bool> fetchDeleteFollowRequest(String access_token, String userId) async {
    final response = await http.delete(
      Uri.parse(url),
      body: jsonEncode({
        "userId": userId,
      }),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw Exception('Some error happen'); // Request Timeout response status code
      },
    );

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
      return false;
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
      return false;
    } else {
      throw Exception('Can\'t not get posts');
      return false;
    }
  }
}