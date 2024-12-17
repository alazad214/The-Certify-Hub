import 'dart:convert';

class TestQuizResponse {
  Quiz? quiz;

  TestQuizResponse({
    this.quiz,
  });

  factory TestQuizResponse.fromRawJson(String str) =>
      TestQuizResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestQuizResponse.fromJson(Map<String, dynamic> json) =>
      TestQuizResponse(
        quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "quiz": quiz?.toJson(),
      };
}

class Quiz {
  int? id;
  String? title;
  int? totalTime;
  List<Question>? questions;

  Quiz({
    this.id,
    this.title,
    this.totalTime,
    this.questions,
  });

  factory Quiz.fromRawJson(String str) => Quiz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        title: json["title"],
        totalTime: json["total_time"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "total_time": totalTime,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  int? id;
  String? text;
  List<Option>? options;

  Question({
    this.id,
    this.text,
    this.options,
  });

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        text: json["text"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  int? id;
  String? text;

  Option({
    this.id,
    this.text,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}
