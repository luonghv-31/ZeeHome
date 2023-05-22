import 'package:http/http.dart' as http;
const String url = 'https://huydt.online/chat/notification';

class DeleteFcmTokenRequest {
  static Future<bool> fetchDeleteFcmToken(String access_token, String fcmToken) async {
    final response = await http.delete(
      Uri.parse(url),
      body: {
        "token": fcmToken,
      },
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
    );
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