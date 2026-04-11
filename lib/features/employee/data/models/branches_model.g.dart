// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllBranches _$AllBranchesFromJson(Map<String, dynamic> json) => AllBranches(
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  branches: (json['branches'] as List<dynamic>?)
      ?.map((e) => BrancheModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllBranchesToJson(AllBranches instance) =>
    <String, dynamic>{
      'pagination': ?instance.pagination?.toJson(),
      'branches': ?instance.branches?.map((e) => e.toJson()).toList(),
    };

BrancheModel _$BrancheModelFromJson(Map<String, dynamic> json) => BrancheModel(
  id: (json['id'] as num?)?.toInt(),
  code: json['code'] as String?,
  name: json['name'] == null
      ? null
      : Name.fromJson(json['name'] as Map<String, dynamic>),
  status: json['status'] as String?,
  desc: json['desc'] as String?,
  lastrecord: (json['lastrecord'] as num?)?.toInt(),
  rootId: json['root_id'] as String?,
  companyId: json['company_id'] as String?,
  deletedAt: json['deleted_at'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$BrancheModelToJson(BrancheModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'code': ?instance.code,
      'name': ?instance.name?.toJson(),
      'status': ?instance.status,
      'desc': ?instance.desc,
      'lastrecord': ?instance.lastrecord,
      'root_id': ?instance.rootId,
      'company_id': ?instance.companyId,
      'deleted_at': ?instance.deletedAt,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
    };
