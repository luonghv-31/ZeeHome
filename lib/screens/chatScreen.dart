import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/authProvider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Container(
        child: Text(authProvider.accessToken),
      );
    });
  }
}
