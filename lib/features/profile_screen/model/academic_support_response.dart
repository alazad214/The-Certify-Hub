import 'dart:convert';

class AcademicSupportResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  AcademicSupportResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  // Factory constructor to parse raw JSON string
  factory AcademicSupportResponse.fromRawJson(String str) =>
      AcademicSupportResponse.fromJson(json.decode(str));

  // Method to convert object to raw JSON string
  String toRawJson() => json.encode(toJson());

  // Factory constructor to parse JSON Map
  factory AcademicSupportResponse.fromJson(Map<String, dynamic> json) =>
      AcademicSupportResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        code: json["code"],
      );

  // Method to convert object to JSON Map
  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  User? user;

  Data({
    this.user,
  });

  // Factory constructor to parse JSON Map
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  // Method to convert object to JSON Map
  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? url;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to parse JSON Map
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        url: json["url"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  // Method to convert object to JSON Map
  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
