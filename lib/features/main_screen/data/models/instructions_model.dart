import 'package:json_annotation/json_annotation.dart';
part 'instructions_model.g.dart';
@JsonSerializable()
class InstructionsModel {
  int? id;
  int? companyId;
  int? branchId;
  String? instPriorities;
  String? name;
  String? subContent;
  String? cover;
  String? image;
  String? dateFrom;
  String? dateTo;
  int? status;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? merchantId;

  InstructionsModel(
      {this.id,
        this.companyId,
        this.branchId,
        this.instPriorities,
        this.name,
        this.subContent,
        this.cover,
        this.image,
        this.dateFrom,
        this.dateTo,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.merchantId});

  factory InstructionsModel.fromJson(Map<String, dynamic> json) =>
      _$InstructionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$InstructionsModelToJson(this);
}