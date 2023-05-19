import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/screens/chat/Widgets/chatPage.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatModel>(context, listen: false).getChatWith();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tin nhắn',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',

          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Thông tin",
          ),
        ],
      ),
    );
  }
}
