import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/following.dart';

class FollowingListRequest {
  static List<Users> parseFollowingList(String responseBody) {
    var h = json.decode(responseBody) as Map<String, dynamic>;
    final hl = Following.fromJson(h).users?.toList();
    return hl!;
  }

  static Future<List<Users>> fetchFollowingList(String access_token, int pageSize, int pageNumber) async {

    final uri = Uri.https('huydt.online', '/api/users/actions/following', {
      'page': pageNumber.toString(),
      'size': pageSize.toString() ,
    });
    final response = await http.get(uri,  headers: <String, String> {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access_token',
    },);

    if (response.statusCode == 200) {
      return compute( parseFollowingList, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}