// To parse this JSON data, do
//
//     final searchCarListModel = searchCarListModelFromJson(jsonString);

import 'dart:convert';

SearchCarListModel searchCarListModelFromJson(String str) => SearchCarListModel.fromJson(json.decode(str));

String searchCarListModelToJson(SearchCarListModel data) => json.encode(data.toJson());

class SearchCarListModel {
  SearchCarListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory SearchCarListModel.fromJson(Map<String, dynamic> json) => SearchCarListModel(
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
    this.carNumber,
    this.model,
    this.carFrontPic,
    this.chassisPic,
    this.rcFront,
    this.rcBack,
    this.insurence,
    this.fcCopy,
    this.reasons,
    this.status,
    this.vendor,
  });

  int? id;
  int? vendorId;
  String? carNumber;
  String? model;
  String? carFrontPic;
  String? chassisPic;
  String? rcFront;
  String? rcBack;
  String? insurence;
  String? fcCopy;
  dynamic reasons;
  String? status;
  Vendor? vendor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    vendorId: json["vendor_id"],
    carNumber: json["car_number"],
    model: json["model"],
    carFrontPic: json["car_front_pic"],
    chassisPic: json["chassis_pic"],
    rcFront: json["rc_front"],
    rcBack: json["rc_back"],
    insurence: json["insurence"],
    fcCopy: json["fc_copy"],
    reasons: json["reasons"],
    status: json["status"],
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "car_number": carNumber,
    "model": model,
    "car_front_pic": carFrontPic,
    "chassis_pic": chassisPic,
    "rc_front": rcFront,
    "rc_back": rcBack,
    "insurence": insurence,
    "fc_copy": fcCopy,
    "reasons": reasons,
    "status": status,
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
