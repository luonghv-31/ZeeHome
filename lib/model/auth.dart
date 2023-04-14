class Auth {
  String access_token;
  String refresh_token;

  Auth({required this.access_token, required this.refresh_token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      access_token: json['access_token'] as String,
      refresh_token: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    data['refresh_token'] = this.refresh_token;
    return data;
  }
}