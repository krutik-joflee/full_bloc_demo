import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.users,
  });

  List<User>? users;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.createdAt,
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.updatedAt,
  });

  DateTime? createdAt;
  String? email;
  String? firstName;
  String? id;
  String? lastName;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["created_at"]),
        email: json["email"],
        firstName: json["first_name"],
        id: json["id"],
        lastName: json["last_name"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "email": email,
        "first_name": firstName,
        "id": id,
        "last_name": lastName,
        "updated_at": updatedAt,
      };
}
