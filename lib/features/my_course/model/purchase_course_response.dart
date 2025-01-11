// import 'dart:convert';

// class PurchasedCourseResponse {
//   String? message;
//   List<PurchaseCourseData>? data;

//   PurchasedCourseResponse({
//     this.message,
//     this.data,
//   });

//   factory PurchasedCourseResponse.fromRawJson(String str) =>
//       PurchasedCourseResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PurchasedCourseResponse.fromJson(Map<String, dynamic> json) =>
//       PurchasedCourseResponse(
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<PurchaseCourseData>.from(
//                 json["data"]!.map((x) => PurchaseCourseData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class PurchaseCourseData {
//   int? id;
//   String? courseTitle;
//   String? courseSlug;
//   String? duration;
//   String? summary;
//   DateTime? lastUpdate;
//   num? coursePrice;
//   String? courseFeatureImage;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   num? progressRate;

//   PurchaseCourseData({
//     this.id,
//     this.courseTitle,
//     this.courseSlug,
//     this.duration,
//     this.summary,
//     this.lastUpdate,
//     this.coursePrice,
//     this.courseFeatureImage,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.progressRate,
//   });

//   factory PurchaseCourseData.fromRawJson(String str) =>
//       PurchaseCourseData.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PurchaseCourseData.fromJson(Map<String, dynamic> json) =>
//       PurchaseCourseData(
//         id: json["id"],
//         courseTitle: json["course_title"],
//         courseSlug: json["course_slug"],
//         duration: json["duration"],
//         summary: json["summary"],
//         lastUpdate: json["last_update"] == null
//             ? null
//             : DateTime.parse(json["last_update"]),
//         coursePrice: json["course_price"],
//         courseFeatureImage: json["course_feature_image"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//         progressRate: json["progress_rate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "course_title": courseTitle,
//         "course_slug": courseSlug,
//         "duration": duration,
//         "summary": summary,
//         "last_update": lastUpdate?.toIso8601String(),
//         "course_price": coursePrice,
//         "course_feature_image": courseFeatureImage,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "deleted_at": deletedAt,
//         "progress_rate": progressRate,
//       };
// }
