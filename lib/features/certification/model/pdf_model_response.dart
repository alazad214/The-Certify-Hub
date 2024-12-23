import 'dart:convert';

class PdfModelResponse {
  bool? success;
  String? message;
  List<PdfData>? data;
  int? code;

  PdfModelResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory PdfModelResponse.fromRawJson(String str) =>
      PdfModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PdfModelResponse.fromJson(Map<String, dynamic> json) =>
      PdfModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<PdfData>.from(json["data"].map((x) => PdfData.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class PdfData {
  int id;
  int courseContentId;
  String filePath;
  String fileType;
  DateTime createdAt;
  DateTime updatedAt;

  PdfData({
    required this.id,
    required this.courseContentId,
    required this.filePath,
    required this.fileType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PdfData.fromRawJson(String str) => PdfData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PdfData.fromJson(Map<String, dynamic> json) => PdfData(
        id: json["id"],
        courseContentId: json["course_content_id"],
        filePath: json["file_path"],
        fileType: json["file_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_content_id": courseContentId,
        "file_path": filePath,
        "file_type": fileType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}


/*

import 'dart:convert';

class PdfModelResponse {
    bool? success;
    String? message;
    List<Datum>? data;
    int? code;

    PdfModelResponse({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    factory PdfModelResponse.fromRawJson(String str) => PdfModelResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PdfModelResponse.fromJson(Map<String, dynamic> json) => PdfModelResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
    };
}

class Datum {
    int? id;
    int? courseContentId;
    String? filePath;
    String? fileType;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.courseContentId,
        this.filePath,
        this.fileType,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        courseContentId: json["course_content_id"],
        filePath: json["file_path"],
        fileType: json["file_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_content_id": courseContentId,
        "file_path": filePath,
        "file_type": fileType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}



 */