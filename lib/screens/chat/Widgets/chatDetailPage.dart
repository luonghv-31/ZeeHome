import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/model/user.dart';
import 'package:zeehome/model/userProvider.dart';
import 'package:zeehome/network/user/get_user_by_id_request.dart';

class ChatDetailPage extends StatefulWidget {
  String userId;
  ChatDetailPage({super.key, required this.userId});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  User? otherUser;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatModel>(context, listen: false).getChatHistory(widget.userId);
    SharedPreferences.getInstance().then((prefs) {
      String access_token = prefs.get('access_token') as String;
      GetUserByIdRequest.fetchUser(access_token, userId).then((value) => {

      });
    });


    super.initState();
  }

  String parseMessageBody(String body) {
    final result = json.decode(body);
    return result['text'].toString();
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatModel, UserProvider>(builder: (context, chatModel, userProvider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://danviet.mediacdn.vn/upload/2-2019/images/2019-04-02/Vi-sao-Kha-Banh-tro-thanh-hien-tuong-dinh-dam-tren-mang-xa-hoi-khabanh-1554192528-width660height597.jpg'),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Ngô Bá Khá",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.info,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: chatModel.messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (chatModel.messages[index].to?.sId == userProvider.userId
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (chatModel.messages[index].to?.sId == userProvider.userId
                            ? Colors.grey.shade200
                            : const Color.fromARGB(255, 144, 249, 242)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        parseMessageBody(chatModel.messages[index].body!),
                        style: const TextStyle(color: Colors.black,fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25, top: 0),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập tin nhắn...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.blue,
                      elevation: 1,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
