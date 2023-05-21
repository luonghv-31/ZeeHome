import 'package:http/http.dart' as http;
import 'package:zeehome/model/houses/house.dart';
const String url = 'https://huydt.online/api/houses';

class DeleteHouseRequest {
  static Future<bool> fetchDeleteHouse(String access_token, String houseId ) async {
    final response = await http.delete(
      Uri.parse('$url/$houseId'),
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