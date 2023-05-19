class ChatUser {
  String gender;
  String phoneNumber;
  String intro;
  String image;
  String birthDate;
  String firstName;
  String lastName;
  String email;
  String registerAt;
  bool banned;
  double avgRating;
  String title;
  String role;
  String userId;

  ChatUser({required this.gender, required this.phoneNumber, required this.intro, required this.image, required this.birthDate,
    required this.firstName, required this.lastName, required this.email, required this.registerAt, required this.banned,
    required this.avgRating, required this.title, required this.role, required this.userId,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      gender: json['gender'] as String,
      phoneNumber: json['phoneNumber'] as String,
      intro: json['intro'] as String,
      image: json['image'] as String,
      birthDate: json['birthDate'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      registerAt: json['registerAt'] as String,
      banned: json['banned'] as bool,
      avgRating: json['avgRating'] as double,
      title: json['title'] as String,
      role: json['role'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['intro'] = this.intro;
    data['image'] = this.image;
    data['birthDate'] = this.birthDate;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['registerAt'] = this.registerAt;
    data['banned'] = this.banned;
    data['avgRating'] = this.avgRating;
    data['title'] = this.title;
    data['role'] = this.role;
    data['userId'] = this.userId;
    return data;
  }
}