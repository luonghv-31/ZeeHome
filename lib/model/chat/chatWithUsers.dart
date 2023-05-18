class ChatWithUsers {
  String? sId;
  List<ChatWith>? chatWith;

  ChatWithUsers({this.sId, this.chatWith});

  ChatWithUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['chatWith'] != null) {
      chatWith = <ChatWith>[];
      json['chatWith'].forEach((v) {
        chatWith!.add(new ChatWith.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.chatWith != null) {
      data['chatWith'] = this.chatWith!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatWith {
  Info? info;
  String? message;
  int? unRead;
  String? lastTimeCommunicate;
  String? sId;

  ChatWith(
      {this.info,
        this.message,
        this.unRead,
        this.lastTimeCommunicate,
        this.sId});

  ChatWith.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    message = json['message'];
    unRead = json['unRead'];
    lastTimeCommunicate = json['lastTimeCommunicate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['message'] = this.message;
    data['unRead'] = this.unRead;
    data['lastTimeCommunicate'] = this.lastTimeCommunicate;
    data['_id'] = this.sId;
    return data;
  }
}

class Info {
  String? sId;
  String? firstName;
  String? lastName;
  String? image;

  Info({this.sId, this.firstName, this.lastName, this.image});

  Info.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}