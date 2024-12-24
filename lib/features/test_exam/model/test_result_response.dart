import 'dart:convert';

class TestResultResponse {
  Quiz? quiz;
  Result? result;
  List<QuestionResult>? questions;
  String? message;

  TestResultResponse({
    this.quiz,
    this.result,
    this.questions,
    this.message,
  });

  factory TestResultResponse.fromRawJson(String str) =>
      TestResultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestResultResponse.fromJson(Map<String, dynamic> json) =>
      TestResultResponse(
        quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        questions: json["questions"] == null
            ? []
            : List<QuestionResult>.from(
                json["questions"]!.map((x) => QuestionResult.fromJson(x))),
        message: json["message"],
      );

  get data => null;

  Map<String, dynamic> toJson() => {
        "quiz": quiz?.toJson(),
        "result": result?.toJson(),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "message": message,
      };
}

class QuestionResult {
  int? questionId;
  String? questionText;
  List<Option>? options;
  String? correctOption;
  bool? isCorrect;
  String? explanation;

  QuestionResult({
    this.questionId,
    this.questionText,
    this.options,
    this.correctOption,
    this.isCorrect,
    this.explanation,
  });

  factory QuestionResult.fromRawJson(String str) =>
      QuestionResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionResult.fromJson(Map<String, dynamic> json) => QuestionResult(
        questionId: json["question_id"],
        questionText: json["question_text"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        correctOption: json["correct_option"],
        isCorrect: json["is_correct"],
        explanation: json["explanation"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_text": questionText,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "correct_option": correctOption,
        "is_correct": isCorrect,
        "explanation": explanation,
      };
}

class Option {
  int? id;
  String? text;
  int? isCorrect;
  bool? isSelected;

  Option({
    this.id,
    this.text,
    this.isCorrect,
    this.isSelected,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
        isCorrect: json["is_correct"],
        isSelected: json["is_selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "is_correct": isCorrect,
        "is_selected": isSelected,
      };
}

class Quiz {
  int? id;
  String? title;

  Quiz({
    this.id,
    this.title,
  });

  factory Quiz.fromRawJson(String str) => Quiz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Result {
  num? score;
  int? totalQuestions;
  num? percentage;

  Result({
    this.score,
    this.totalQuestions,
    this.percentage,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        score: json["score"],
        totalQuestions: json["total_questions"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "total_questions": totalQuestions,
        "percentage": percentage,
      };
}
