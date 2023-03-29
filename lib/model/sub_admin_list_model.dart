import 'dart:convert';

SubAdminListModel subAdminListModelFromJson(String str) => SubAdminListModel.fromJson(json.decode(str));

String subAdminListModelToJson(SubAdminListModel data) => json.encode(data.toJson());

class SubAdminListModel {
  SubAdminListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory SubAdminListModel.fromJson(Map<String, dynamic> json) => SubAdminListModel(
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
    this.subadminList,
  });

  List<SubadminList>? subadminList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    subadminList: List<SubadminList>.from(json["subadminList"].map((x) => SubadminList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subadminList": List<dynamic>.from(subadminList!.map((x) => x.toJson())),
  };
}

class SubadminList {
  SubadminList({
    this.name,
    this.email,
    this.contact,
    this.designation,
  });

  String? name;
  String? email;
  String? contact;
  String? designation;

  factory SubadminList.fromJson(Map<String, dynamic> json) => SubadminList(
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
    "designation": designation,
  };
}
