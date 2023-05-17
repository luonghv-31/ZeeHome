import 'package:flutter/material.dart';
import 'package:zeehome/model/user.dart';

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

  String get firstName => _firstName;

  String get lastName => _lastName;

  double get balance => _balance;

  String get userId => _userId;

  void updateUser(String firstName, String lastName, String birthDate, String gender, String intro, String image, String phoneNumber) {
    _gender = gender;
    _phoneNumber = phoneNumber;
    _intro = intro;
    _image = image;
    _birthDate = birthDate;
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }

  User getUserObj () {
    return User(
      gender: _gender,
      phoneNumber: _phoneNumber,
      intro: _intro,
      image: image,
      birthDate: _birthDate,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      registerAt: _registerAt,
      banned: _banned,
      avgRating: _avgRating,
      title: _title,
      role: _role,
      userId: _userId,
      balance: _balance,
    );
  }
}