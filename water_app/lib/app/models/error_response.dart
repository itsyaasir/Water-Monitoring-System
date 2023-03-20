import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.code,
    required this.message,
    required this.error,
    required this.success,
    this.data,
  });

  int code;
  String message;
  String error;
  bool success;
  dynamic data;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
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
