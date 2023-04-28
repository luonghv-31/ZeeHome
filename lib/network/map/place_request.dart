import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PlaceRequest {
  static Future<String?> fetchPlaces(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      return response.body;
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }
}