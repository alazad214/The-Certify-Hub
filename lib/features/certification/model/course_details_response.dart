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
        data: json["data"] == null
            ? null
            : CourseDetailsData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class CourseDetailsData {
  int? id;
  String? courseTitle;
  String? courseSlug;
  String? duration;
  String? summary;
  DateTime? lastUpdate;
  double? coursePrice;
  String? courseFeatureImage;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<CourseModule>? courseModules;
  List<Purchase>? purchases;
  String? aiName;
  String? aiUrl;
  String? aiDescription;
  String? aiPicture;

  CourseDetailsData({
    this.id,
    this.courseTitle,
    this.courseSlug,
    this.duration,
    this.summary,
    this.lastUpdate,
    this.coursePrice,
    this.courseFeatureImage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.courseModules,
    this.purchases,
    this.aiName,
    this.aiUrl,
    this.aiDescription,
    this.aiPicture,
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
        lastUpdate: json["last_update"] == null
            ? null
            : DateTime.parse(json["last_update"]),
        coursePrice: json["course_price"]?.toDouble(),
        courseFeatureImage: json["course_feature_image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        courseModules: json["course_modules"] == null
            ? []
            : List<CourseModule>.from(
                json["course_modules"]!.map((x) => CourseModule.fromJson(x))),
        purchases: json["purchases"] == null
            ? []
            : List<Purchase>.from(
                json["purchases"]!.map((x) => Purchase.fromJson(x))),
        aiName: json["ai_name"],
        aiUrl: json["ai_url"],
        aiDescription: json["ai_description"],
        aiPicture: json["ai_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_title": courseTitle,
        "course_slug": courseSlug,
        "duration": duration,
        "summary": summary,
        "last_update": lastUpdate?.toIso8601String(),
        "course_price": coursePrice,
        "course_feature_image": courseFeatureImage,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "course_modules": courseModules == null
            ? []
            : List<dynamic>.from(courseModules!.map((x) => x.toJson())),
        "purchases": purchases == null
            ? []
            : List<dynamic>.from(purchases!.map((x) => x.toJson())),
      };
}

class CourseModule {
  int? id;
  String? courseModuleName;
  int? courseId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? lessonCount;

  CourseModule({
    this.id,
    this.courseModuleName,
    this.courseId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lessonCount,
  });

  factory CourseModule.fromRawJson(String str) =>
      CourseModule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseModule.fromJson(Map<String, dynamic> json) => CourseModule(
        id: json["id"],
        courseModuleName: json["course_module_name"],
        courseId: json["course_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        lessonCount: json["lesson_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_module_name": courseModuleName,
        "course_id": courseId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "lesson_count": lessonCount,
      };
}

class Purchase {
  num? id;
  num? userId;
  num? courseId;
  num? isPurchased;
  DateTime? createdAt;
  DateTime? updatedAt;

  Purchase({
    this.id,
    this.userId,
    this.courseId,
    this.isPurchased,
    this.createdAt,
    this.updatedAt,
  });

  factory Purchase.fromRawJson(String str) =>
      Purchase.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        userId: json["user_id"],
        courseId: json["course_id"],
        isPurchased: json["is_purchased"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "course_id": courseId,
        "is_purchased": isPurchased,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
