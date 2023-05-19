import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/chat/chatUser.dart';
import 'package:zeehome/model/user.dart';

const String url = 'https://huydt.online/api/users';

class GetUserByIdRequest {

  static ChatUser parseUser(String responseBody) {
    var response = json.decode(responseBody);
    ChatUser user = ChatUser.fromJson(response);
    return user;
  }

  static Future<ChatUser> fetchUser(String access_token, String userId) async {
    final response = await http.get(
      Uri.parse('$url/$userId'),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      return compute( parseUser, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}