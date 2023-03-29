// To parse this JSON data, do
//
//     final carListModel = carListModelFromJson(jsonString);

import 'dart:convert';

CarListModel carListModelFromJson(String str) => CarListModel.fromJson(json.decode(str));

String carListModelToJson(CarListModel data) => json.encode(data.toJson());

class CarListModel {
  CarListModel({
     this.statusCode,
     this.code,
     this.message,
     this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory CarListModel.fromJson(Map<String, dynamic> json) => CarListModel(
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
     this.carList,
  });

  List<CarList>? carList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    carList: List<CarList>.from(json["carList"].map((x) => CarList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carList": List<dynamic>.from(carList!.map((x) => x.toJson())),
  };
}

class CarList {
  CarList({
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

  factory CarList.fromJson(Map<String, dynamic> json) => CarList(
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
  };
}
