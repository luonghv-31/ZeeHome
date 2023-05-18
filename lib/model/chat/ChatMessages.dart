class ChatMessages {
  List<Messages>? messages;

  ChatMessages({this.messages});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  From? from;
  From? to;
  String? createAt;
  String? body;

  Messages({this.from, this.to, this.createAt, this.body});

  Messages.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    createAt = json['createAt'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['createAt'] = this.createAt;
    data['body'] = this.body;
    return data;
  }
}

class From {
  String? sId;
  String? firstName;
  String? lastName;
  String? image;

  From({this.sId, this.firstName, this.lastName, this.image});

  From.fromJson(Map<String, dynamic> json) {
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