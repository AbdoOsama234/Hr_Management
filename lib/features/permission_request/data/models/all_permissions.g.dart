// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPermissions _$AllPermissionsFromJson(Map<String, dynamic> json) =>
    AllPermissions(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      permissions: (json['permission'] as List<dynamic>?)
          ?.map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPermissionsToJson(AllPermissions instance) =>
    <String, dynamic>{
      'pagination': ?instance.pagination?.toJson(),
      'permission': ?instance.permissions?.map((e) => e.toJson()).toList(),
    };
