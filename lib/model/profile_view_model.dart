import 'dart:convert';

ProfileViewModel profileViewModelFromJson(String str) => ProfileViewModel.fromJson(json.decode(str));

String profileViewModelToJson(ProfileViewModel data) => json.encode(data.toJson());

class ProfileViewModel {
  ProfileViewModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) => ProfileViewModel(
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
    this.name,
    this.email,
    this.contact,
    this.password,
  });

  String? name;
  String? email;
  String? contact;
  String? password;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
    "password": password,
  };
}
