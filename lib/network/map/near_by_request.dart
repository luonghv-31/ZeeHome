import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/nearByPlace.dart';

const String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

class GetNearByPlaceRequest {
  static NearbyPlacesResponse parseNearBy(String responseBody) {
    var response = json.decode(responseBody);
    NearbyPlacesResponse np = NearbyPlacesResponse.fromJson(response);
    return np;
  }

  static Future<NearbyPlacesResponse> fetchNearBy(String location, int radius, String type ) async {
    final uri = Uri.https('maps.googleapis.com', '/maps/api/place/nearbysearch/json', {
      'location': location,
      'radius': radius.toString(),
      'type': type,
      'key': 'AIzaSyAT-29Vo1xQZU4nCKMCgvKfRivVJ2KkHhU',
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      // developer.log(response.body);
      return compute( parseNearBy, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}