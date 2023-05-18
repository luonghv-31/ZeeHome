import 'package:flutter/material.dart';
import 'package:zeehome/model/authProvider.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/model/houseProvider.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/utils/theme.dart';
import 'screens/login/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      ChangeNotifierProvider(create: (_) => HouseProvider()),
      ChangeNotifierProvider(create: (_) => ChatModel()),
    ], child: MaterialApp(
      theme: lightTheme(context),
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: EasyLoading.init(),
    ));
  }
}