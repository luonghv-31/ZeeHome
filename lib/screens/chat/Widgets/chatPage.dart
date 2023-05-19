import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/screens/chat/Widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  String parseImage (String? imageUrl) {
    if (imageUrl != null) {
      final splitted = imageUrl.split('/');
      return 'https://d38jr024nxkzmx.cloudfront.net/${splitted[3]}';
    }
    return 'https://d38jr024nxkzmx.cloudfront.net/1fdecb44-f964-44e9-ac29-3906228b0835_MjAyMy0wNS0xN1QxMTo0MToyNy4yNTE3ODIyNTM%3D_payment.png';
  }

  String parseMessageBody(String body) {
    final result = json.decode(body);
    return result['text'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(builder: (context, chatModelProvider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: chatModelProvider.chatWiths.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: '${chatModelProvider.chatWiths[index].info?.firstName} ${chatModelProvider.chatWiths[index].info?.lastName}',
                    messageText: parseMessageBody(chatModelProvider.chatWiths[index].message!),
                    imageUrl: parseImage(chatModelProvider.chatWiths[index].info?.image),
                    time: chatModelProvider.chatWiths[index].lastTimeCommunicate.toString(),
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                    userId: '${chatModelProvider.chatWiths[index].info?.sId}',
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
