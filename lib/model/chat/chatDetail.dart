import 'package:zeehome/model/chat/ChatMessages.dart';

class ChatDetail {
  int? totalUnreadWithUser;
  int? totalUnread;
  Chat? chat;

  ChatDetail({this.totalUnreadWithUser, this.totalUnread, this.chat});

  ChatDetail.fromJson(Map<String, dynamic> json) {
    totalUnreadWithUser = json['totalUnreadWithUser'];
    totalUnread = json['totalUnread'];
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUnreadWithUser'] = this.totalUnreadWithUser;
    data['totalUnread'] = this.totalUnread;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class Chat {
  String? roomId;
  String? body;
  From? from;
  From? to;
  String? createAt;
  String? sId;

  Chat({this.roomId, this.body, this.from, this.to, this.createAt, this.sId});

  Chat.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    body = json['body'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    createAt = json['createAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['body'] = this.body;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['createAt'] = this.createAt;
    data['_id'] = this.sId;
    return data;
  }
}

