// To parse this JSON data, do
//
//     final vendorListModel = vendorListModelFromJson(jsonString);

import 'dart:convert';

VendorListModel vendorListModelFromJson(String str) => VendorListModel.fromJson(json.decode(str));

String vendorListModelToJson(VendorListModel data) => json.encode(data.toJson());

class VendorListModel {
  VendorListModel({
     this.statusCode,
     this.code,
     this.message,
     this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory VendorListModel.fromJson(Map<String, dynamic> json) => VendorListModel(
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
     this.vendorList,
  });

  List<VendorList>? vendorList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    vendorList: List<VendorList>.from(json["vendorList"].map((x) => VendorList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendorList": List<dynamic>.from(vendorList!.map((x) => x.toJson())),
  };
}

class VendorList {
  VendorList({
     this.id,
     this.name,
     this.contact,
     this.password,
     this.adharFront,
     this.adharBack,
     this.pancard,
     this.passbook,
     this.rentalAgreement1,
     this.rentalAgreement2,
    this.reasons,
     this.status,
  });

  int? id;
  String? name;
  String? contact;
  String? password;
  String? adharFront;
  String? adharBack;
  String? pancard;
  String? passbook;
  String? rentalAgreement1;
  String? rentalAgreement2;
  dynamic reasons;
  String? status;

  factory VendorList.fromJson(Map<String, dynamic> json) => VendorList(
    id: json["id"],
    name: json["name"],
    contact: json["contact"],
    password: json["password"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    pancard: json["pancard"],
    passbook: json["passbook"],
    rentalAgreement1: json["rental_agreement_1"],
    rentalAgreement2: json["rental_agreement_2"],
    reasons: json["reasons"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "contact": contact,
    "password": password,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "pancard": pancard,
    "passbook": passbook,
    "rental_agreement_1": rentalAgreement1,
    "rental_agreement_2": rentalAgreement2,
    "reasons": reasons,
    "status": status,
  };
}
