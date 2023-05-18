import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zeehome/model/chat/ChatMessages.dart';
import 'package:zeehome/model/chat/chatDetail.dart';
import 'package:zeehome/model/chat/chatWithUsers.dart';

class ChatModel with ChangeNotifier {
  List<ChatWith> chatWiths = [];
  List<Messages> messages = [];

  late IO.Socket socket;
  
  void init(String access_token) {
    socket = IO.io('https://huydt.online',
        IO.OptionBuilder()
          .setPath('/chat/socket.io')
          .enableAutoConnect()
          .setTransports(['websocket'])
          .setAuth({
            "token": access_token
          })
          .build(),
    );

    socket.onConnect((_) {
      print('connect');
      socket.emit('FE_get_chat_with', {});
    });

    // socket.on('event', (data) => print(data));
    socket.on('FE_receive_message', (data) {
      ChatDetail chatDetail = ChatDetail.fromJson(data);
      Messages newMessage = Messages(from: chatDetail.chat?.from, to: chatDetail.chat?.to, body: chatDetail.chat?.body, createAt: chatDetail.chat?.createAt);
      messages.add(newMessage);
      notifyListeners();
    });

    socket.on('FE_receive_history_chat', (data) {
      ChatMessages chatMessages = ChatMessages.fromJson(data);
      messages = chatMessages.messages!.reversed.toList();
      notifyListeners();
    });

    socket.on('FE_receive_chat_with', (data) {
      ChatWithUsers chatWithUsers = ChatWithUsers.fromJson(data);
      chatWiths = chatWithUsers.chatWith!;
      notifyListeners();
    });

    socket.on('FE_reset_unread_done', (data) => {
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

  void deleteChatHistory() {

  }

  // void sendMessage(String text, String receiverChatID) {
  //   messages.add(Message(text, currentUser.chatID, receiverChatID));
  //   socketIO.sendMessage(
  //     'send_message',
  //     json.encode({
  //       'receiverChatID': receiverChatID,
  //       'senderChatID': currentUser.chatID,
  //       'content': text,
  //     }),
  //   );
  //   notifyListeners();
  // }
}