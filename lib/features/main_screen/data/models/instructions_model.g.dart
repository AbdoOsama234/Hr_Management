// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionsModel _$InstructionsModelFromJson(Map<String, dynamic> json) =>
    InstructionsModel(
      id: (json['id'] as num?)?.toInt(),
      companyId: (json['company_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      instPriorities: json['inst_priorities'] as String?,
      name: json['name'] as String?,
      subContent: json['sub_content'] as String?,
      cover: json['cover'] as String?,
      image: json['image'] as String?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdBy: (json['created_by'] as num?)?.toInt(),
      updatedBy: (json['updated_by'] as num?)?.toInt(),
      deletedBy: (json['deleted_by'] as num?)?.toInt(),
      deletedAt: (json['deleted_at'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      merchantId: (json['merchant_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InstructionsModelToJson(InstructionsModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'company_id': ?instance.companyId,
      'branch_id': ?instance.branchId,
      'inst_priorities': ?instance.instPriorities,
      'name': ?instance.name,
      'sub_content': ?instance.subContent,
      'cover': ?instance.cover,
      'image': ?instance.image,
      'date_from': ?instance.dateFrom,
      'date_to': ?instance.dateTo,
      'status': ?instance.status,
      'created_by': ?instance.createdBy,
      'updated_by': ?instance.updatedBy,
      'deleted_by': ?instance.deletedBy,
      'deleted_at': ?instance.deletedAt,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'merchant_id': ?instance.merchantId,
    };
