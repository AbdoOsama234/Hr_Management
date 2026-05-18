import 'package:json_annotation/json_annotation.dart';
import '../../../../data/models/pagination_model.dart';

part 'loan_model.g.dart';


@JsonSerializable()
class LoanModel {
  int? id;
  int? companyId;
  String? requestNumber;
  int? branchesId;
  String? employeesId;
  String? requestDate;
  String? loanType;
  String? amount;
  int? installments;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? merchantId;

  LoanModel(
      {this.id,
        this.companyId,
        this.requestNumber,
        this.branchesId,
        this.employeesId,
        this.requestDate,
        this.loanType,
        this.amount,
        this.installments,
        this.status,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.merchantId});

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);

}


@JsonSerializable()
class AllLoans {
  Pagination? pagination;
  List<LoanModel>? loans;

  AllLoans({this.pagination, this.loans});

  factory AllLoans.fromJson(Map<String, dynamic> json) =>
      _$AllLoansFromJson(json);

  Map<String, dynamic> toJson() => _$AllLoansToJson(this);


}

