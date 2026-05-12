// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) => LoanModel(
  id: (json['id'] as num?)?.toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  requestNumber: json['request_number'] as String?,
  branchesId: (json['branches_id'] as num?)?.toInt(),
  employeesId: json['employees_id'] as String?,
  requestDate: json['request_date'] as String?,
  loanType: json['loan_type'] as String?,
  amount: json['amount'] as String?,
  installments: (json['installments'] as num?)?.toInt(),
  status: json['status'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  deletedAt: json['deleted_at'] as String?,
  createdBy: (json['created_by'] as num?)?.toInt(),
  updatedBy: json['updated_by'] as String?,
  deletedBy: json['deleted_by'] as String?,
  merchantId: json['merchant_id'] as String?,
);

Map<String, dynamic> _$LoanModelToJson(LoanModel instance) => <String, dynamic>{
  'id': ?instance.id,
  'company_id': ?instance.companyId,
  'request_number': ?instance.requestNumber,
  'branches_id': ?instance.branchesId,
  'employees_id': ?instance.employeesId,
  'request_date': ?instance.requestDate,
  'loan_type': ?instance.loanType,
  'amount': ?instance.amount,
  'installments': ?instance.installments,
  'status': ?instance.status,
  'notes': ?instance.notes,
  'created_at': ?instance.createdAt,
  'updated_at': ?instance.updatedAt,
  'deleted_at': ?instance.deletedAt,
  'created_by': ?instance.createdBy,
  'updated_by': ?instance.updatedBy,
  'deleted_by': ?instance.deletedBy,
  'merchant_id': ?instance.merchantId,
};

AllLoans _$AllLoansFromJson(Map<String, dynamic> json) => AllLoans(
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  loans: (json['loans'] as List<dynamic>?)
      ?.map((e) => LoanModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AllLoansToJson(AllLoans instance) => <String, dynamic>{
  'pagination': ?instance.pagination?.toJson(),
  'loans': ?instance.loans?.map((e) => e.toJson()).toList(),
};
