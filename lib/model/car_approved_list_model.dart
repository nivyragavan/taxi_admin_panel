// To parse this JSON data, do
//
//     final carApprovedList = carApprovedListFromJson(jsonString);

import 'dart:convert';

CarApprovedList carApprovedListFromJson(String str) => CarApprovedList.fromJson(json.decode(str));

String carApprovedListToJson(CarApprovedList data) => json.encode(data.toJson());

class CarApprovedList {
  CarApprovedList({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory CarApprovedList.fromJson(Map<String, dynamic> json) => CarApprovedList(
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
    this.carApproval,
  });

  List<CarApproval>? carApproval;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    carApproval: List<CarApproval>.from(json["carApproval"].map((x) => CarApproval.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carApproval": List<dynamic>.from(carApproval!.map((x) => x.toJson())),
  };
}

class CarApproval {
  CarApproval({
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
    this.vendorName,
    this.vendorContact,
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
  String? vendorName;
  String? vendorContact;

  factory CarApproval.fromJson(Map<String, dynamic> json) => CarApproval(
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
    vendorName: json["vendor.name"],
    vendorContact: json["vendor.contact"],
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
    "vendor.name": vendorName,
    "vendor.contact": vendorContact,
  };
}
