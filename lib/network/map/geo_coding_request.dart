import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/geoCoding.dart';

const String url = 'https://maps.googleapis.com/maps/api/geocode/json';

class GetGeoCodingRequest {
  static GeoCoding parseGeoCoding(String responseBody) {
    var response = json.decode(responseBody);
    GeoCoding gc = GeoCoding.fromJson(response);
    return gc;
  }

  static Future<GeoCoding> fetchGeoCoding(String placeId ) async {
    final uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
      'place_id': placeId,
      'key': 'AIzaSyAT-29Vo1xQZU4nCKMCgvKfRivVJ2KkHhU',
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      // developer.log(response.body);
      return compute( parseGeoCoding, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}