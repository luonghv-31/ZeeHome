import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/houses/houseList.dart';

class MyHouseListRequest {
  static List<House> parseMyHouseList(String responseBody) {
    var h = json.decode(responseBody) as Map<String, dynamic>;
    final hl = HouseList.fromJson(h).houses?.toList();
    return hl!;
  }

  static Future<List<House>> fetchMyHouseList(String ownerId, bool isShowAll, int pageSize, int pageNumber) async {
    final uri = Uri.https('huydt.online', '/api/houses',
      {
        'queryFor': 'all',
        'queryType': 'normal',
        'showInvisible': isShowAll.toString(),
        'ownerId': ownerId.toString(),
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString(),
      }
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return compute( parseMyHouseList, utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}