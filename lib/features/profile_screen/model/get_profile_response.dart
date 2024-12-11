import 'dart:convert';

class ProfileResponse {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProfileResponse({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  ProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
    int? code,
  }) =>
      ProfileResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory ProfileResponse.fromRawJson(String str) =>
      ProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "code": code,
      };
}

class Data {
  User user;

  Data({
    required this.user,
  });

  Data copyWith({
    User? user,
  }) =>
      Data(
        user: user ?? this.user,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatar: avatar ?? this.avatar,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        avatar: json["user_avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "user_avatar": avatar,
      };
}
