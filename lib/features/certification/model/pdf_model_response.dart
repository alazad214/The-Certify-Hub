import 'dart:convert';

class PdfModelResponse {
  bool? success;
  String? message;
  PdfData? data;
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
        data: json["data"] == null ? null : PdfData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class PdfData {
  int? moduleId;
  dynamic moduleName;
  List<FileElement>? files;

  PdfData({
    this.moduleId,
    this.moduleName,
    this.files,
  });

  factory PdfData.fromRawJson(String str) => PdfData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PdfData.fromJson(Map<String, dynamic> json) => PdfData(
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "module_id": moduleId,
        "module_name": moduleName,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class FileElement {
  int? id;
  int? courseContentId;
  String? filePath;
  String? fileType;
  DateTime? createdAt;
  DateTime? updatedAt;

  FileElement({
    this.id,
    this.courseContentId,
    this.filePath,
    this.fileType,
    this.createdAt,
    this.updatedAt,
  });

  factory FileElement.fromRawJson(String str) =>
      FileElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        courseContentId: json["course_content_id"],
        filePath: json["file_path"],
        fileType: json["file_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  get files => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_content_id": courseContentId,
        "file_path": filePath,
        "file_type": fileType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
