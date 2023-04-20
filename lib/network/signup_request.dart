import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:moment_dart/moment_dart.dart';

 const String url = 'https://huydt.online/api/auth/signup';

class SignUpRequest {
  static createAcount(
    String gender,
    String phoneNumber,
    String birthDate,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    
    String registerAt = '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now().add( const Duration(hours: 9, minutes: -10)))}Z';
    Map data = {
      'gender': gender,
      'phoneNumber': phoneNumber,
      'intro': 'Some thing need EDIT !',
      'image': 'string',
      'birthDate': birthDate,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'registerAt': registerAt,
      'banned': true,
      'avgRating': 0,
      'password': password
    };
    print(data);

    final response = await http.post(
      Uri.parse(url),     
      headers:  {
        "Content-Type":"application/json"
      },
       body: jsonEncode(data),
       encoding: Encoding.getByName('utf-8')
    );
    
    print(response.statusCode);
  }
}
