import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseRequest<T> {
  T? data;

  BaseRequest(this.data);

  factory BaseRequest.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseRequestFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseRequestToJson(this, toJsonT);
}
