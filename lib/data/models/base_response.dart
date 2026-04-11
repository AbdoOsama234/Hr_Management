import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  int? statusCode;
  bool? status;
  String? message;
  T? result;

  BaseResponse(this.statusCode, this.status, this.message, this.result);

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(T Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
