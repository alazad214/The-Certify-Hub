import 'dart:convert';

class LessonsModelResponse {
  bool? success;
  String? message;
  LessonData? data;
  int? code;

  LessonsModelResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory LessonsModelResponse.fromRawJson(String str) =>
      LessonsModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LessonsModelResponse.fromJson(Map<String, dynamic> json) =>
      LessonsModelResponse(
        success: json["success"],
        message: json["message"],
        data: LessonData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "code": code,
      };
}

class LessonData {
  int id;
  String courseModuleName;
  int courseId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<CourseContent> courseContents;

  LessonData({
    required this.id,
    required this.courseModuleName,
    required this.courseId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.courseContents,
  });

  factory LessonData.fromRawJson(String str) =>
      LessonData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LessonData.fromJson(Map<String, dynamic> json) => LessonData(
        id: json["id"],
        courseModuleName: json["course_module_name"],
        courseId: json["course_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        courseContents: List<CourseContent>.from(
            json["course_contents"].map((x) => CourseContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_module_name": courseModuleName,
        "course_id": courseId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "course_contents":
            List<dynamic>.from(courseContents.map((x) => x.toJson())),
      };
}

class CourseContent {
  int id;
  String contentTitle;
  String videoFile;
  String contentLength;
  int courseId;
  int courseModuleId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  CourseContent({
    required this.id,
    required this.contentTitle,
    required this.videoFile,
    required this.contentLength,
    required this.courseId,
    required this.courseModuleId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CourseContent.fromRawJson(String str) =>
      CourseContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseContent.fromJson(Map<String, dynamic> json) => CourseContent(
        id: json["id"],
        contentTitle: json["content_title"],
        videoFile: json["video_file"],
        contentLength: json["content_length"],
        courseId: json["course_id"],
        courseModuleId: json["course_module_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_title": contentTitle,
        "video_file": videoFile,
        "content_length": contentLength,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
