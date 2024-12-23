import 'dart:convert';

class PracticeQuizResponse {
  PracticeQuiz? quiz;

  PracticeQuizResponse({
    this.quiz,
  });

  factory PracticeQuizResponse.fromRawJson(String str) =>
      PracticeQuizResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PracticeQuizResponse.fromJson(Map<String, dynamic> json) =>
      PracticeQuizResponse(
        quiz: json["quiz"] == null ? null : PracticeQuiz.fromJson(json["quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "quiz": quiz?.toJson(),
      };
}

class PracticeQuiz {
  int? id;
  String? title;
  int? totalTime;
  List<Question>? questions;

  PracticeQuiz({
    this.id,
    this.title,
    this.totalTime,
    this.questions,
  });

  factory PracticeQuiz.fromRawJson(String str) =>
      PracticeQuiz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PracticeQuiz.fromJson(Map<String, dynamic> json) => PracticeQuiz(
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
  int? correctOption;
  bool? isCorrect;
  String? explanation;
  List<Option>? options;

  Question({
    this.id,
    this.text,
    this.correctOption,
    this.isCorrect,
    this.explanation,
    this.options,
  });

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        text: json["text"],
        correctOption: json["correct_option"],
        isCorrect: json["is_correct"],
        explanation: json["explanation"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "correct_option": correctOption,
        "is_correct": isCorrect,
        "explanation": explanation,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  int? id;
  String? text;
  int? isCorrect;

  Option({
    this.id,
    this.text,
    this.isCorrect,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "is_correct": isCorrect,
      };
}
