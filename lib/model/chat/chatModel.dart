import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zeehome/model/chat/ChatMessages.dart';
import 'package:zeehome/model/chat/chatDetail.dart';
import 'package:zeehome/model/chat/chatWithUsers.dart';


class ChatModel with ChangeNotifier {
  List<ChatWith> chatWiths = [];
  List<Messages> messages = [];

 bool hasChanged = false; 

  late IO.Socket socket;

  void init(String access_token) {
    socket = IO.io(
      'https://huydt.online',
      IO.OptionBuilder()
          .setPath('/chat/socket.io')
          .enableAutoConnect()
          .setTransports(['websocket']).setAuth(
              {"token": access_token}).build(),
    );

    socket.onConnect((_) {
      print('connect');
      socket.emit('FE_get_chat_with', {});
    });

   
    socket.on('FE_receive_message', (data) {
      ChatDetail chatDetail = ChatDetail.fromJson(data);
      Messages newMessage = Messages(
          from: chatDetail.chat?.from,
          to: chatDetail.chat?.to,
          body: chatDetail.chat?.body,
          createAt: chatDetail.chat?.createAt);
      messages.add(newMessage);    
  
    hasChanged =true;
      getChatWith();  
      
      notifyListeners();
    });

    socket.on('FE_receive_history_chat', (data) {
      ChatMessages chatMessages = ChatMessages.fromJson(data);
      messages = chatMessages.messages!.reversed.toList();
      hasChanged =true ;

      notifyListeners();
    });

    socket.on('FE_receive_chat_with', (data) {
      ChatWithUsers chatWithUsers = ChatWithUsers.fromJson(data);
      chatWiths = chatWithUsers.chatWith!;
      notifyListeners();
    });

    socket.on(
        'FE_reset_unread_done',
        (data) => {
              debugPrint(data.toString()),
            });

    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }

  void getChatWith() {
    socket.emit('FE_get_chat_with', {});
  }

  void getChatHistory(String userId) {
    socket.emit('FE_get_chat_history', {
      "withId": userId,
    });
  }

  String getDate() {
    debugPrint(DateTime.now().toString());
    return DateTime.now().toString();
  }

  void sendTextMessage(String text, From fromUser, From toUser) {
    String body = jsonEncode({
      "type": "text",
      "text": text,
    });
    socket.emit('FE_send_message', {
      "to": toUser.sId,
      "body": body,
    });
    messages.add(
        Messages(from: fromUser, to: toUser, createAt: getDate(), body: body));
    notifyListeners();

    //
  }

  void sendImageMessage(
      String text, String imageUrl, From fromUser, From toUser) {
    String body = jsonEncode({
      "type": "text",
      "text": text,
      "image": imageUrl,
    });
    socket.emit('FE_send_message', {
      "to": toUser.sId,
      "body": body,
    });
    messages.add(
        Messages(from: fromUser, to: toUser, createAt: getDate(), body: body));
    notifyListeners();
  }

  void sendLinkMessage(String text, String link, From fromUser, From toUser) {
    String body = jsonEncode({
      "type": "text",
      "text": text,
      "link": link,
    });
    socket.emit('FE_send_message', {
      "to": toUser.sId,
      "body": body,
    });
    messages.add(
        Messages(from: fromUser, to: toUser, createAt: getDate(), body: body));
    notifyListeners();
  }
}
