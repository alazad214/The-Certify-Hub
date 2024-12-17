import 'dart:convert';

class MockTestResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  MockTestResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory MockTestResponse.fromRawJson(String str) =>
      MockTestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MockTestResponse.fromJson(Map<String, dynamic> json) =>
      MockTestResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  List<QuizData>? quizzes;

  Data({
    this.quizzes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizzes: json["quizzes"] == null
            ? []
            : List<QuizData>.from(
                json["quizzes"]!.map((x) => QuizData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quizzes": quizzes == null
            ? []
            : List<dynamic>.from(quizzes!.map((x) => x.toJson())),
      };
}

class QuizData {
  int? id;
  String? title;
  int? totalTime;
  int? courseId;
  int? totalQuestions;

  QuizData(
      {this.id,
      this.title,
      this.totalTime,
      this.courseId,
      this.totalQuestions});

  factory QuizData.fromRawJson(String str) =>
      QuizData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        id: json["id"],
        title: json["title"],
        totalTime: json["total_time"],
        courseId: json["course_id"],
        totalQuestions: json["total_questions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "total_time": totalTime,
        "course_id": courseId,
        "total_questions": totalQuestions,
      };
}
