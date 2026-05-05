// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
  token: json['token'] as String?,
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'token': ?instance.token,
      'user': ?instance.user?.toJson(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'] as String?,
  confirmPassword: json['confirm_password'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  companyId: (json['company_id'] as num?)?.toInt(),
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
  employeesId: (json['employees_id'] as num?)?.toInt(),
  merchantId: (json['merchant_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'email': ?instance.email,
  'email_verified_at': ?instance.emailVerifiedAt,
  'confirm_password': ?instance.confirmPassword,
  'created_at': ?instance.createdAt,
  'updated_at': ?instance.updatedAt,
  'company_id': ?instance.companyId,
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
  'merchant_id': ?instance.merchantId,
};
