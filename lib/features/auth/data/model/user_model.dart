import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class LoginModel {
  String? token;
  User? user;

  LoginModel({this.token, this.user});
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? confirmPassword;
  String? createdAt;
  String? updatedAt;
  int? companyId;
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
  int? merchantId;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.confirmPassword,
    this.createdAt,
    this.updatedAt,
    this.companyId,
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
    this.merchantId,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
