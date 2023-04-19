import 'package:http/http.dart' as http;

const String url = 'https://huydt.online/api/payment';

class GetBankingRequest {

  // static User parseUser(String responseBody) {
  //   var response = json.decode(responseBody);
  //   User user = User.fromJson(response);
  //   return user;
  // }

  static Future<String> fetchBanking(String access_token, int amount , String orderAttachment, String type ) async {
    final response = await http.post(
      Uri.parse('$url/$type'),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token',
      },
      body: {
        'amount': amount,
        'orderAttachment': orderAttachment
      },
    );
    if (response.statusCode == 200) {
      // return compute( parseUser, response.body);
      return 'susccess';
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 401) {
      throw Exception('unauthorized');
    } else {
      throw Exception('Can\'t not get posts');
    }
  }
}