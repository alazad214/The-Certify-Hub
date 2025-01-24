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
        data: json["data"] == null ? null : LessonData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class LessonData {
  int? moduleId;
  String? moduleTitle;
  List<CourseContent>? contents;

  LessonData({
    this.moduleId,
    this.moduleTitle,
    this.contents,
  });

  factory LessonData.fromRawJson(String str) =>
      LessonData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LessonData.fromJson(Map<String, dynamic> json) => LessonData(
        moduleId: json["module_id"],
        moduleTitle: json["module_title"],
        contents: json["contents"] == null
            ? []
            : List<CourseContent>.from(
                json["contents"]!.map((x) => CourseContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "module_id": moduleId,
        "module_title": moduleTitle,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class CourseContent {
  int? id;
  String? contentTitle;
  String? videoFile;
  String? contentLength;
  int? courseId;
  int? courseModuleId;
  int? status;
  int? beforePurchase;
  bool? viewed;
  bool? isPurchased;
  List<ContentFile>? contentFiles; // Added for PDFs

  CourseContent({
    this.id,
    this.contentTitle,
    this.videoFile,
    this.contentLength,
    this.courseId,
    this.courseModuleId,
    this.status,
    this.beforePurchase,
    this.viewed,
    this.isPurchased,
    this.contentFiles,
  });

  factory CourseContent.fromRawJson(String str) =>
      CourseContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseContent.fromJson(Map<String, dynamic> json) => CourseContent(
        id: json["id"],
        contentTitle: json["content_title"] ?? '',
        videoFile: json["video_file"],
        contentLength: json["content_length"],
        courseId: json["course_id"],
        courseModuleId: json["course_module_id"],
        status: json["status"],
        beforePurchase: json["before_purchase"],
        viewed: json["viewed"],
        isPurchased: json["is_purchased"],
        contentFiles: json["content_files"] == null
            ? []
            : List<ContentFile>.from(
                json["content_files"].map((x) => ContentFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_title": contentTitle,
        "video_file": videoFile,
        "content_length": contentLength,
        "course_id": courseId,
        "course_module_id": courseModuleId,
        "status": status,
        "before_purchase": beforePurchase,
        "viewed": viewed,
        "is_purchased": isPurchased,
        "content_files": contentFiles == null
            ? []
            : List<dynamic>.from(contentFiles!.map((x) => x.toJson())),
      };
}

class ContentFile {
  int? id;
  String? fileUrl;

  ContentFile({this.id, this.fileUrl});

  factory ContentFile.fromJson(Map<String, dynamic> json) => ContentFile(
        id: json["id"],
        fileUrl: json["file_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_url": fileUrl,
      };
}
