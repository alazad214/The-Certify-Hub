import 'dart:convert';

class CourseDetailsResponse {
  bool? success;
  String? message;
  CourseDetailsData? data;
  int? code;

  CourseDetailsResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory CourseDetailsResponse.fromRawJson(String str) =>
      CourseDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CourseDetailsResponse(
        success: json["success"],
        message: json["message"],
        data: CourseDetailsData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "code": code,
      };
}

class CourseDetailsData {
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
  List<CourseModule> courseModules;

  CourseDetailsData({
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
    required this.courseModules,
  });

  factory CourseDetailsData.fromRawJson(String str) =>
      CourseDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseDetailsData.fromJson(Map<String, dynamic> json) =>
      CourseDetailsData(
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
        courseModules: List<CourseModule>.from(
            json["course_modules"].map((x) => CourseModule.fromJson(x))),
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
        "course_modules":
            List<dynamic>.from(courseModules.map((x) => x.toJson())),
      };
}

class CourseModule {
  int id;
  String courseModuleName;
  int courseId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int lessonCount;

  CourseModule({
    required this.id,
    required this.courseModuleName,
    required this.courseId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.lessonCount,
  });

  factory CourseModule.fromRawJson(String str) =>
      CourseModule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseModule.fromJson(Map<String, dynamic> json) => CourseModule(
        id: json["id"],
        courseModuleName: json["course_module_name"],
        courseId: json["course_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        lessonCount: json["lesson_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_module_name": courseModuleName,
        "course_id": courseId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "lesson_count": lessonCount,
      };
}
