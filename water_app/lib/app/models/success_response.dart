import 'dart:convert';

SuccessResponse successResponseFromJson(String str) =>
    SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) =>
    json.encode(data.toJson());

class SuccessResponse {
  SuccessResponse({
    required this.code,
    required this.data,
    required this.success,
  });

  int code;
  dynamic data;
  bool success;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
        code: json["code"],
        data: json["data"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "success": success,
      };
}
