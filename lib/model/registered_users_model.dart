

import 'dart:convert';

RegisteredUsersListModel registeredUsersListModelFromJson(String str) => RegisteredUsersListModel.fromJson(json.decode(str));

String registeredUsersListModelToJson(RegisteredUsersListModel data) => json.encode(data.toJson());

class RegisteredUsersListModel {
  RegisteredUsersListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory RegisteredUsersListModel.fromJson(Map<String, dynamic> json) => RegisteredUsersListModel(
    statusCode: json["statusCode"],
    code: json["code"],
    message: json["message"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "code": code,
    "message": message,
    "body": body!.toJson(),
  };
}

class Body {
  Body({
    this.userlist,
  });

  List<Userlist>? userlist;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    userlist: List<Userlist>.from(json["userlist"].map((x) => Userlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userlist": List<dynamic>.from(userlist!.map((x) => x.toJson())),
  };
}

class Userlist {
  Userlist({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.passwordText,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? contact;
  String? passwordText;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Userlist.fromJson(Map<String, dynamic> json) => Userlist(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    passwordText: json["password_text"],
    location: json["location"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact": contact,
    "password_text": passwordText,
    "location": location,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
