// To parse this JSON data, do
//
//     final errorSignInResponse = errorSignInResponseFromJson(jsonString);

import 'dart:convert';

ErrorSignInResponse errorSignInResponseFromJson(String str) =>
    ErrorSignInResponse.fromJson(json.decode(str));

String errorSignInResponseToJson(ErrorSignInResponse data) =>
    json.encode(data.toJson());

class ErrorSignInResponse {
  ErrorSignInResponse({
    required this.code,
    required this.message,
    required this.error,
    required this.success,
    this.data,
  });

  int code;
  int message;
  String error;
  bool success;
  dynamic data;

  factory ErrorSignInResponse.fromJson(Map<String, dynamic> json) =>
      ErrorSignInResponse(
        code: json["code"],
        message: json["message"],
        error: json["error"],
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "error": error,
        "success": success,
        "data": data,
      };
}
