// To parse this JSON data, do
//
//     final driverListModel = driverListModelFromJson(jsonString);

import 'dart:convert';

DriverListModel driverListModelFromJson(String str) => DriverListModel.fromJson(json.decode(str));

String driverListModelToJson(DriverListModel data) => json.encode(data.toJson());

class DriverListModel {
  DriverListModel({
     this.statusCode,
     this.code,
     this.message,
     this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory DriverListModel.fromJson(Map<String, dynamic> json) => DriverListModel(
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
     this.driverList,
  });

  List<DriverList>? driverList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    driverList: List<DriverList>.from(json["driverList"].map((x) => DriverList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "driverList": List<dynamic>.from(driverList!.map((x) => x.toJson())),
  };
}

class DriverList {
  DriverList({
     this.id,
     this.vendorId,
     this.name,
     this.contact,
     this.district,
     this.licenseNumber,
     this.expieryDate,
     this.profilePic,
     this.adharFront,
     this.adharBack,
     this.licenseFront,
     this.licenseBack,
    this.reasons,
     this.status,
  });

  int? id;
  int? vendorId;
  String? name;
  String? contact;
  String? district;
  String? licenseNumber;
  DateTime? expieryDate;
  String? profilePic;
  String? adharFront;
  String? adharBack;
  String? licenseFront;
  String? licenseBack;
  String? reasons;
  String? status;

  factory DriverList.fromJson(Map<String, dynamic> json) => DriverList(
    id: json["id"],
    vendorId: json["vendor_id"],
    name: json["name"],
    contact: json["contact"],
    district: json["district"],
    licenseNumber: json["license_number"],
    expieryDate: DateTime.parse(json["expiery_date"]),
    profilePic: json["profile_pic"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    licenseFront: json["license_front"],
    licenseBack: json["license_back"],
    reasons: json["reasons"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "name": name,
    "contact": contact,
    "district": district,
    "license_number": licenseNumber,
    "expiery_date": "${expieryDate!.year.toString().padLeft(4, '0')}-${expieryDate!.month.toString().padLeft(2, '0')}-${expieryDate!.day.toString().padLeft(2, '0')}",
    "profile_pic": profilePic,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "license_front": licenseFront,
    "license_back": licenseBack,
    "reasons": reasons,
    "status": status,
  };
}
