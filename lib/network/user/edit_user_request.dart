import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'https://huydt.online/api/users/me/my-info';

class EditUserRequest {

  static Future<bool> fetchEditUser(String access_token, String firstName, String lastName, String birthDate, String gender, String intro, String image, String phoneNumber) async {
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode({
          "gender": gender,
          "phoneNumber": phoneNumber,
          "intro": intro,
          "image": image,
          "birthDate": birthDate,
          "firstName": firstName,
          "lastName": lastName,
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
    if (response.statusCode == 200) {
      // developer.log(response.body);
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