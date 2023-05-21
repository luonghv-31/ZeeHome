import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeehome/model/chat/ChatMessages.dart';
import 'package:zeehome/model/chat/chatModel.dart';
import 'package:zeehome/model/chat/chatUser.dart';
import 'package:zeehome/model/user.dart';
import 'package:zeehome/model/userProvider.dart';

class ChatDetailPage extends StatefulWidget {
  ChatUser chatUser;
  ChatDetailPage({super.key, required this.chatUser});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ChatModel>(context, listen: false).getChatHistory(widget.chatUser.userId);
    super.initState();
  }

  TextEditingController chatTextController = TextEditingController();

  String parseMessageBody(String body) {
    final result = json.decode(body);
    return result['text'].toString();
  }

  @override
  void dispose() {
    chatTextController.dispose();
    super.dispose();
  }


  void handleSubmitChat (User myInfo) {
    Provider.of<ChatModel>(context, listen: false).sendTextMessage(
        chatTextController.text,
        From(sId: myInfo.userId, firstName: myInfo.firstName, lastName: myInfo.lastName),
        From(sId: widget.chatUser.userId, firstName: widget.chatUser.firstName, lastName: widget.chatUser.lastName));
    chatTextController.text = '';
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
                  CircleAvatar(
                    backgroundImage: NetworkImage('${widget.chatUser?.image}'),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${widget.chatUser?.firstName} ${widget.chatUser?.lastName}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
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
            Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ListView.builder(
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
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
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
                    Expanded(
                      child: TextField(
                        controller: chatTextController,
                        decoration: const InputDecoration(
                          hintText: "Nhập tin nhắn...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        handleSubmitChat(userProvider.getUserObj());
                      },
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
