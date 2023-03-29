
import 'dart:convert';

ManualBookingHistoryModel manualBookingHistoryModelFromJson(String str) => ManualBookingHistoryModel.fromJson(json.decode(str));

String manualBookingHistoryModelToJson(ManualBookingHistoryModel data) => json.encode(data.toJson());

class ManualBookingHistoryModel {
  ManualBookingHistoryModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory ManualBookingHistoryModel.fromJson(Map<String, dynamic> json) => ManualBookingHistoryModel(
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
    this.bookedRides,
  });

  List<BookedRide>? bookedRides;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    bookedRides: List<BookedRide>.from(json["bookedRides"].map((x) => BookedRide.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookedRides": List<dynamic>.from(bookedRides!.map((x) => x.toJson())),
  };
}

class BookedRide {
  BookedRide({
    this.id,
    this.name,
    this.phonenumber,
    this.pickupLocation,
    this.pickupDate,
    this.dropLocation,
    this.dropDate,
    this.package,
    this.rentalhour,
    this.cab,
    this.subadminId,
    this.km,
    this.price,
    this.driverName,
    this.startOtp,
    this.endOtp,
    this.cancelledBy,
    this.cancelledReason,
    this.tripStatus,
    this.status,
    this.subadmin,
  });

  int? id;
  String? name;
  String? phonenumber;
  String? pickupLocation;
  DateTime? pickupDate;
  String? dropLocation;
  DateTime? dropDate;
  String? package;
  int? rentalhour;
  String? cab;
  int? subadminId;
  dynamic km;
  dynamic price;
  dynamic driverName;
  dynamic startOtp;
  dynamic endOtp;
  dynamic cancelledBy;
  dynamic cancelledReason;
  String? tripStatus;
  int? status;
  Subadmin? subadmin;

  factory BookedRide.fromJson(Map<String, dynamic> json) => BookedRide(
    id: json["id"],
    name: json["name"],
    phonenumber: json["phonenumber"],
    pickupLocation: json["pickup_location"],
    pickupDate: DateTime.parse(json["pickup_date"]),
    dropLocation: json["drop_location"],
    dropDate: DateTime.parse(json["drop_date"]),
    package: json["package"],
    rentalhour: json["rentalhour"],
    cab: json["cab"],
    subadminId: json["subadmin_id"],
    km: json["km"],
    price: json["price"],
    driverName: json["driver_name"],
    startOtp: json["start_otp"],
    endOtp: json["end_otp"],
    cancelledBy: json["cancelled_by"],
    cancelledReason: json["cancelled_reason"],
    tripStatus: json["trip_status"],
    status: json["status"],
    subadmin: Subadmin.fromJson(json["subadmin"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonenumber": phonenumber,
    "pickup_location": pickupLocation,
    "pickup_date": pickupDate!.toIso8601String(),
    "drop_location": dropLocation,
    "drop_date": dropDate!.toIso8601String(),
    "package": package,
    "rentalhour": rentalhour,
    "cab": cab,
    "subadmin_id": subadminId,
    "km": km,
    "price": price,
    "driver_name": driverName,
    "start_otp": startOtp,
    "end_otp": endOtp,
    "cancelled_by": cancelledBy,
    "cancelled_reason": cancelledReason,
    "trip_status": tripStatus,
    "status": status,
    "subadmin": subadmin!.toJson(),
  };
}

class Subadmin {
  Subadmin({
    this.name,
    this.phonenumber,
  });

  String? name;
  String? phonenumber;

  factory Subadmin.fromJson(Map<String, dynamic> json) => Subadmin(
    name: json["name"],
    phonenumber: json["phonenumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phonenumber": phonenumber,
  };
}
