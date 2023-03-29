import 'dart:convert';

AssignedDriversListModel assignedDriversListModelFromJson(String str) => AssignedDriversListModel.fromJson(json.decode(str));

String assignedDriversListModelToJson(AssignedDriversListModel data) => json.encode(data.toJson());

class AssignedDriversListModel {
  AssignedDriversListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory AssignedDriversListModel.fromJson(Map<String, dynamic> json) => AssignedDriversListModel(
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
    this.assignList,
  });

  List<AssignList>? assignList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    assignList: List<AssignList>.from(json["assignList"].map((x) => AssignList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assignList": List<dynamic>.from(assignList!.map((x) => x.toJson())),
  };
}

class AssignList {
  AssignList({
    this.id,
    this.vendorId,
    this.carId,
    this.driverId,
    this.name,
    this.contact,
    this.licenseNumber,
    this.status,
    this.carCarNumber,
    this.vendorName,
    this.vendorContact,
    this.driverName,
    this.driverContact,
  });

  int? id;
  int? vendorId;
  int? carId;
  int? driverId;
  String? name;
  String? contact;
  String? licenseNumber;
  String? status;
  String? carCarNumber;
  String? vendorName;
  String? vendorContact;
  String? driverName;
  String? driverContact;

  factory AssignList.fromJson(Map<String, dynamic> json) => AssignList(
    id: json["id"],
    vendorId: json["vendor_id"],
    carId: json["car_id"],
    driverId: json["driver_id"],
    name: json["name"],
    contact: json["contact"],
    licenseNumber: json["license_number"],
    status: json["status"],
    carCarNumber: json["car.car_number"],
    vendorName: json["vendor.name"],
    vendorContact: json["vendor.contact"],
    driverName: json["driver.name"],
    driverContact: json["driver.contact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "car_id": carId,
    "driver_id": driverId,
    "name": name,
    "contact": contact,
    "license_number": licenseNumber,
    "status": status,
    "car.car_number": carCarNumber,
    "vendor.name": vendorName,
    "vendor.contact": vendorContact,
    "driver.name": driverName,
    "driver.contact": driverContact,
  };
}
