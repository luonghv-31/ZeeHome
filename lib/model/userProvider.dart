import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _gender = '';
  String _phoneNumber = '';
  String _intro = '';
  String _image = '';
  String _birthDate = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _registerAt = '';
  bool _banned = false;
  double _avgRating = 0;
  String _title = '';
  String _role = '';
  String _userId = '';
  double _balance = 0;

  void set (String gender, String phoneNumber, String intro, String image, String birthDate, String firstName, String lastName, String email, String registerAt, bool banned, double avgRating, String title, String role, String userId, double balance) {
    _gender = gender;
    _phoneNumber = phoneNumber;
    _intro = intro;
    _image = image;
    _birthDate = birthDate;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _registerAt = registerAt;
    _banned = banned;
    _avgRating = avgRating;
    _title = title;
    _role = role;
    _userId = userId;
    _balance = balance;
    notifyListeners();
  }

  String get name => '$_firstName $_lastName';

  String get email => _email;

  String get image => _image;
}