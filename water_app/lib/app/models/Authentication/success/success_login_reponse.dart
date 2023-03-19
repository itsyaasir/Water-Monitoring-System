import 'dart:convert';

SignInReponse signInReponseFromJson(String str) =>
    SignInReponse.fromJson(json.decode(str));

String signInReponseToJson(SignInReponse data) => json.encode(data.toJson());

class SignInReponse {
  SignInReponse({
    required this.code,
    required this.data,
    required this.success,
  });

  int code;
  Data data;
  bool success;

  factory SignInReponse.fromJson(Map<String, dynamic> json) => SignInReponse(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.email,
  });

  String id;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
