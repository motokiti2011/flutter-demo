import 'dart:convert';

class User {
  final int userId;
  final String userName;
  final String mailAdress;

  User({
    required this.userId,
    required this.userName,
    required this.mailAdress,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        userName: json["userName"],
        mailAdress: json["mailAdress"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "mailAdress": mailAdress,
      };
}

User userModelFromJson(String str) => User.fromJson(json.decode(str));

String userModelToJson(User user) => json.encode(user.toJson());
