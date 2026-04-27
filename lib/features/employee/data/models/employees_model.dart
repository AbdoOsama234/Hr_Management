import 'package:json_annotation/json_annotation.dart';

import '../../../../data/models/pagination_model.dart';
part 'employees_model.g.dart';

@JsonSerializable()
class AllUsers {
  Pagination? pagination;
  @JsonKey(name: "branches") // 👈 أهم سطر
  List<UsersModel>? users;

  AllUsers({this.pagination, this.users});

  factory AllUsers.fromJson(Map<String, dynamic> json) =>
      _$AllUsersFromJson(json);
  Map<String, dynamic> toJson() => _$AllUsersToJson(this);
}

@JsonSerializable()
class UsersModel {
  int? id;
  String? code;
  String? name;
  String? status;
  String? desc;
  int? lastrecord;
  String? rootId;
  String? companyId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  int? isSales;
  int? hierarchyId;
  int? levelId;
  int? isManager;
  int? isSupervisor;
  int? isHallManager;
  int? isAssistant;
  int? departmentsId;
  int? branchesId;
  int? isOperation;
  int? isPurchaseStore;
  int? isFinance;
  int? isAccountant;
  int? employeesId;

  UsersModel({
    this.id,
    this.code,
    this.name,
    this.status,
    this.desc,
    this.lastrecord,
    this.rootId,
    this.companyId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.isSales,
    this.hierarchyId,
    this.levelId,
    this.isManager,
    this.isSupervisor,
    this.isHallManager,
    this.isAssistant,
    this.departmentsId,
    this.branchesId,
    this.isOperation,
    this.isPurchaseStore,
    this.isFinance,
    this.isAccountant,
    this.employeesId,
  });
  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
