import 'dart:convert';

class CourseResponse {
  bool? success;
  String? message;
  List<Course>? data;
  int? code;

  CourseResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory CourseResponse.fromRawJson(String str) =>
      CourseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        success: json["success"],
        message: json["message"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
        code: json["code"],
      );

  get length => null;

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Course {
  int id;
  String courseTitle;
  String courseSlug;
  String duration;
  String summary;
  DateTime lastUpdate;
  double coursePrice;
  String courseFeatureImage;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Course({
    required this.id,
    required this.courseTitle,
    required this.courseSlug,
    required this.duration,
    required this.summary,
    required this.lastUpdate,
    required this.coursePrice,
    required this.courseFeatureImage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseTitle: json["course_title"],
        courseSlug: json["course_slug"],
        duration: json["duration"],
        summary: json["summary"],
        lastUpdate: DateTime.parse(json["last_update"]),
        coursePrice: json["course_price"],
        courseFeatureImage: json["course_feature_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_title": courseTitle,
        "course_slug": courseSlug,
        "duration": duration,
        "summary": summary,
        "last_update": lastUpdate.toIso8601String(),
        "course_price": coursePrice,
        "course_feature_image": courseFeatureImage,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
