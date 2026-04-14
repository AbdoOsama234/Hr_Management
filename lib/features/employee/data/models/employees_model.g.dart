// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUsers _$AllUsersFromJson(Map<String, dynamic> json) => AllUsers(
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  users: (json['branches'] as List<dynamic>?)
      ?.map((e) => UsersModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllUsersToJson(AllUsers instance) => <String, dynamic>{
  'pagination': ?instance.pagination?.toJson(),
  'branches': ?instance.users?.map((e) => e.toJson()).toList(),
};

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
  id: (json['id'] as num?)?.toInt(),
  code: json['code'] as String?,
  name: json['name'] as String?,
  status: json['status'] as String?,
  desc: json['desc'] as String?,
  lastrecord: (json['lastrecord'] as num?)?.toInt(),
  rootId: json['root_id'] as String?,
  companyId: json['company_id'] as String?,
  deletedAt: json['deleted_at'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'] as String?,
  password: json['password'] as String?,
  rememberToken: json['remember_token'] as String?,
  isSales: (json['is_sales'] as num?)?.toInt(),
  hierarchyId: (json['hierarchy_id'] as num?)?.toInt(),
  levelId: (json['level_id'] as num?)?.toInt(),
  isManager: (json['is_manager'] as num?)?.toInt(),
  isSupervisor: (json['is_supervisor'] as num?)?.toInt(),
  isHallManager: (json['is_hall_manager'] as num?)?.toInt(),
  isAssistant: (json['is_assistant'] as num?)?.toInt(),
  departmentsId: (json['departments_id'] as num?)?.toInt(),
  branchesId: (json['branches_id'] as num?)?.toInt(),
  isOperation: (json['is_operation'] as num?)?.toInt(),
  isPurchaseStore: (json['is_purchase_store'] as num?)?.toInt(),
  isFinance: (json['is_finance'] as num?)?.toInt(),
  isAccountant: (json['is_accountant'] as num?)?.toInt(),
  employeesId: json['employees_id'] as String?,
);

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'code': ?instance.code,
      'name': ?instance.name,
      'status': ?instance.status,
      'desc': ?instance.desc,
      'lastrecord': ?instance.lastrecord,
      'root_id': ?instance.rootId,
      'company_id': ?instance.companyId,
      'deleted_at': ?instance.deletedAt,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
      'email': ?instance.email,
      'email_verified_at': ?instance.emailVerifiedAt,
      'password': ?instance.password,
      'remember_token': ?instance.rememberToken,
      'is_sales': ?instance.isSales,
      'hierarchy_id': ?instance.hierarchyId,
      'level_id': ?instance.levelId,
      'is_manager': ?instance.isManager,
      'is_supervisor': ?instance.isSupervisor,
      'is_hall_manager': ?instance.isHallManager,
      'is_assistant': ?instance.isAssistant,
      'departments_id': ?instance.departmentsId,
      'branches_id': ?instance.branchesId,
      'is_operation': ?instance.isOperation,
      'is_purchase_store': ?instance.isPurchaseStore,
      'is_finance': ?instance.isFinance,
      'is_accountant': ?instance.isAccountant,
      'employees_id': ?instance.employeesId,
    };
