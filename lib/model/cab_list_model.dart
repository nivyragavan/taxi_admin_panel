import 'dart:convert';

CabListModel cabListModelFromJson(String str) => CabListModel.fromJson(json.decode(str));

String cabListModelToJson(CabListModel data) => json.encode(data.toJson());

class CabListModel {
  CabListModel({
    this.statusCode,
    this.code,
    this.message,
    this.body,
  });

  int? statusCode;
  int? code;
  String? message;
  Body? body;

  factory CabListModel.fromJson(Map<String, dynamic> json) => CabListModel(
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
    this.cabsList,
  });

  List<CabsList>? cabsList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    cabsList: List<CabsList>.from(json["cabsList"].map((x) => CabsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cabsList": List<dynamic>.from(cabsList!.map((x) => x.toJson())),
  };
}

class CabsList {
  CabsList({
    this.id,
    this.cabNames,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? cabNames;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CabsList.fromJson(Map<String, dynamic> json) => CabsList(
    id: json["id"],
    cabNames: json["cab_names"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cab_names": cabNames,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
