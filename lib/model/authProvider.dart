import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _accessToken = '';

  set accessToken (String ct) {
    _accessToken = ct;
    notifyListeners();
  }

  void setAccessToken (String ct) {
    _accessToken = ct;
    notifyListeners();
  }

  String get accessToken => _accessToken;
}