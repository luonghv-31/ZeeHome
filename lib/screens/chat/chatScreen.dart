import 'package:flutter/material.dart';
import 'package:zeehome/screens/chat/Widgets/chatPage.dart';

class ChatScreen extends StatelessWidget {
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
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
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
