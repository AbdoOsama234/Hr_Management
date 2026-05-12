// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanRequest _$LoanRequestFromJson(Map<String, dynamic> json) => LoanRequest(
  branchesId: (json['branches_id'] as num?)?.toInt(),
  employeesId: (json['employees_id'] as num?)?.toInt(),
  requestDate: json['request_date'] as String?,
  loanType: json['loan_type'] as String?,
  amount: json['amount'] as String?,
  installments: (json['installments'] as num?)?.toInt(),
  status: json['status'] as String?,
  notes: json['notes'] as String?,
  createdBy: (json['created_by'] as num?)?.toInt(),
  companyId: (json['company_id'] as num?)?.toInt(),
  requestNumber: json['request_number'] as String?,
  updatedAt: json['updated_at'] as String?,
  createdAt: json['created_at'] as String?,
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$LoanRequestToJson(LoanRequest instance) =>
    <String, dynamic>{
      'branches_id': ?instance.branchesId,
      'employees_id': ?instance.employeesId,
      'request_date': ?instance.requestDate,
      'loan_type': ?instance.loanType,
      'amount': ?instance.amount,
      'installments': ?instance.installments,
      'status': ?instance.status,
      'notes': ?instance.notes,
      'created_by': ?instance.createdBy,
      'company_id': ?instance.companyId,
      'request_number': ?instance.requestNumber,
      'updated_at': ?instance.updatedAt,
      'created_at': ?instance.createdAt,
      'id': ?instance.id,
    };
