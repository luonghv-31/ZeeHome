import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String url = 'https://huydt.online/api/payment/vnpay';

class GetVnpayRequest {

  static Future<String> fetchVnPay(String access_token, int amount , String orderAttachment) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'amount': amount,
        'orderAttachment': orderAttachment
      }),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      return response.body.toString();
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}