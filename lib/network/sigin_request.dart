
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:zeehome/model/auth.dart';
// import 'dart:developer' as developer;

// const String urlSignUp = 'https://huydt.online/api/auth/signup';

// class SignUpRequest{
 
//     static Future<Auth> fetchAuth(String gender, String phoneNumber, String birthDate, String firstName, String lastName, String email, String registerAt, String password) async {
//     String intro='Some thing need EDIT !' ;
//     String image='String'; 
//     var avgRating=0 ;
//     bool banned = true;
//     final response = await http.post(
//         Uri.parse(url),
//         headers: <String, String> {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         encoding: Encoding.getByName('utf-8'),
//         body: {
//             gender: gender,
//             phoneNumber: phoneNumber,
//             intro: 'Some thing need EDIT !',
//             image: 'string',
//             birthDate: birthDate,
//             firstName: firstName,
//             lastName: lastName,
//             email: email,
//             registerAt: registerAt,
//             banned: true,
//             avgRating: 0,
//             password: password
//         },
//     );
//     developer.log('${response.statusCode}');
//     if (response.statusCode == 201) {
//       // developer.log(response.body);
//       throw Exception('the user was successfully created');
//     } else if (response.statusCode == 400) {
//       throw Exception('Bad request');
//     } 
//   }
// }
// }