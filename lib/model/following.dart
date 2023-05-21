class Following {
  List<Users>? users;
  int? totalPage;
  int? currentPage;

  Following({this.users, this.totalPage, this.currentPage});

  Following.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = this.totalPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Users {
  String? gender;
  String? phoneNumber;
  String? intro;
  String? image;
  String? birthDate;
  String? firstName;
  String? lastName;
  String? email;
  String? registerAt;
  bool? banned;
  double? avgRating;
  String? title;
  String? role;
  String? userId;

  Users(
      {this.gender,
        this.phoneNumber,
        this.intro,
        this.image,
        this.birthDate,
        this.firstName,
        this.lastName,
        this.email,
        this.registerAt,
        this.banned,
        this.avgRating,
        this.title,
        this.role,
        this.userId});

  Users.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    intro = json['intro'];
    image = json['image'];
    birthDate = json['birthDate'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    registerAt = json['registerAt'];
    banned = json['banned'];
    avgRating = json['avgRating'];
    title = json['title'];
    role = json['role'];
    userId = json['userId'];
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