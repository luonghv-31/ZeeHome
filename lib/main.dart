import 'package:flutter/material.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/utils/theme.dart';
import 'screens/loginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ], child: MaterialApp(
      theme: lightTheme(context),
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));
  }
}