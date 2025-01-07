import 'dart:convert';

class TrackContentResponse {
    String? message;
    Data? data;

    TrackContentResponse({
        this.message,
        this.data,
    });

    factory TrackContentResponse.fromRawJson(String str) => TrackContentResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrackContentResponse.fromJson(Map<String, dynamic> json) => TrackContentResponse(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? courseModuleId;
    int? completionRate;
    List<Content>? contents;

    Data({
        this.courseModuleId,
        this.completionRate,
        this.contents,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        courseModuleId: json["course_module_id"],
        completionRate: json["completion_rate"],
        contents: json["contents"] == null ? [] : List<Content>.from(json["contents"]!.map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "course_module_id": courseModuleId,
        "completion_rate": completionRate,
        "contents": contents == null ? [] : List<dynamic>.from(contents!.map((x) => x.toJson())),
    };
}

class Content {
    int? id;
    dynamic title;
    bool? viewed;

    Content({
        this.id,
        this.title,
        this.viewed,
    });

    factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        viewed: json["viewed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "viewed": viewed,
    };
}
