import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zeehome/model/post.dart';
import 'package:http/http.dart' as http;

const String url = 'https://jsonplaceholder.typicode.com/posts';

class NetworkRequest {

  static List<Post> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  static Future<List<Post>> fetchPosts({int page = 1}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return compute( parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}