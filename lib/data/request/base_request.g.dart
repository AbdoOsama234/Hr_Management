// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest<T> _$BaseRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BaseRequest<T>(_$nullableGenericFromJson(json['data'], fromJsonT));

Map<String, dynamic> _$BaseRequestToJson<T>(
  BaseRequest<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': ?_$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
