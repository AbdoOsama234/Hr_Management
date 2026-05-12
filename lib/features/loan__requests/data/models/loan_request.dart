import 'package:json_annotation/json_annotation.dart';

part 'loan_request.g.dart';

@JsonSerializable()
class LoanRequest {
  int? branchesId;
  int? employeesId;
  String? requestDate;
  String? loanType;
  String? amount;
  int? installments;
  String? status;
  String? notes;
  int? createdBy;
  int? companyId;
  String? requestNumber;
  String? updatedAt;
  String? createdAt;
  int? id;

  LoanRequest(
      {this.branchesId,
        this.employeesId,
        this.requestDate,
        this.loanType,
        this.amount,
        this.installments,
        this.status,
        this.notes,
        this.createdBy,
        this.companyId,
        this.requestNumber,
        this.updatedAt,
        this.createdAt,
        this.id});

  factory LoanRequest.fromJson(Map<String, dynamic> json) =>
      _$LoanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoanRequestToJson(this);
}


