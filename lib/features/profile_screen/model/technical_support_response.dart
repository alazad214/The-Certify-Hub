import 'dart:convert';

class TechnicalSupportResponse {
  bool? success;
  String? message;
  TechnicalData? data;
  int? code;

  TechnicalSupportResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  // Factory constructor to parse raw JSON
  factory TechnicalSupportResponse.fromRawJson(String str) =>
      TechnicalSupportResponse.fromJson(json.decode(str));

  // Method to convert the object back to raw JSON
  String toRawJson() => json.encode(toJson());

  // Factory constructor to parse JSON Map
  factory TechnicalSupportResponse.fromJson(Map<String, dynamic> json) =>
      TechnicalSupportResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? TechnicalData.fromJson(json["data"]) : null,
        code: json["code"],
      );

  // Method to convert the object to a JSON Map
  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class TechnicalData {
  TechData? user;

  TechnicalData({
    this.user,
  });

  factory TechnicalData.fromJson(Map<String, dynamic> json) => TechnicalData(
        user: json["user"] != null ? TechData.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class TechData {
  int? id;
  String? url;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TechData({
    this.id,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TechData.fromJson(Map<String, dynamic> json) => TechData(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
