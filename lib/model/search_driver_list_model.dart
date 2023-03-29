// To parse this JSON data, do
//
//     final searchDriverListModel = searchDriverListModelFromJson(jsonString);

import 'dart:convert';

SearchDriverListModel searchDriverListModelFromJson(String str) => SearchDriverListModel.fromJson(json.decode(str));

String searchDriverListModelToJson(SearchDriverListModel data) => json.encode(data.toJson());

class SearchDriverListModel {
  SearchDriverListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory SearchDriverListModel.fromJson(Map<String, dynamic> json) => SearchDriverListModel(
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
    this.recordsTotal,
    this.recordsFiltered,
    this.data,
  });

  int? recordsTotal;
  int? recordsFiltered;
  List<Datum>? data;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    recordsTotal: json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordsTotal": recordsTotal,
    "recordsFiltered": recordsFiltered,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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
    this.createdAt,
    this.updatedAt,
    this.vendor,
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
  dynamic reasons;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Vendor? vendor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vendor: Vendor.fromJson(json["vendor"]),
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "vendor": vendor!.toJson(),
  };
}

class Vendor {
  Vendor({
    this.name,
    this.contact,
  });

  String? name;
  String? contact;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    name: json["name"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
  };
}
