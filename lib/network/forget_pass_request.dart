import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = 'https://huydt.online/api/auth/reset';

class ResetPass {
  static sendEmail(String email) async{
    Map data = {
      'email': email
    };
    final response = await http.post(
      Uri.parse(url),     
      headers:  {
        "Content-Type":"application/json"
      },
       body: jsonEncode(data),
       encoding: Encoding.getByName('utf-8')
    );
    print(response.statusCode);
    return response;
  }
}

