import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zeehome/model/houses/house.dart';
const String url = 'https://huydt.online/api/houses';

class UpdateHouseRequest {

  static Future<bool> fetchUpdateHouse(String access_token, House houseInfo ) async {
    debugPrint(houseInfo.rooms.toString());
    final response = await http.put(
      Uri.parse('https://huydt.online/api/houses/${houseInfo.houseId}'),
      body: jsonEncode({
        // 'latitude': houseInfo.latitude,
        // 'longitude': houseInfo.longitude,
        'title': houseInfo.title,
        'description': houseInfo.description,
        // 'address': houseInfo.address,
        // 'ward': houseInfo.ward,
        // 'district': houseInfo.district,
        // 'province': houseInfo.province,
        'houseType': houseInfo.houseType,
        'houseCategory': houseInfo.houseCategory,
        'price': houseInfo.price,
        'square': houseInfo.square,
        'ac': houseInfo.ac,
        'parking': houseInfo.parking,
        'elevator': houseInfo.elevator,
        'pet': houseInfo.pet,
        'bathRooms': houseInfo.bathRooms,
        'bedRooms': houseInfo.bedRooms,
        'maintenanceFee': houseInfo.maintenanceFee,
        'furnished': houseInfo.furnished,
        'images': houseInfo.images,
        'thumbnail': houseInfo.thumbnail,
        "video": houseInfo.video,
        'rooms': houseInfo.rooms,
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

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}