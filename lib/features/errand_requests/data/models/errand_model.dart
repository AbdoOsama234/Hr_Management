import 'package:json_annotation/json_annotation.dart';

import '../../../../data/models/pagination_model.dart';

part 'errand_model.g.dart';

@JsonSerializable()
class ErrandModel {
  int? id;
  int? companyId;
  String? requestNumber;
  String? requestDate;
  String? tripType;
  String? employeesId;
  String? alternateEmployeeId;
  String? managementId;
  int? branchesId;
  String? fromDate;
  String? toDate;
  int? daysCount;
  String? status;
  String? requestNotes;
  String? statusNotes;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? merchantId;

  ErrandModel(
      {this.id,
        this.companyId,
        this.requestNumber,
        this.requestDate,
        this.tripType,
        this.employeesId,
        this.alternateEmployeeId,
        this.managementId,
        this.branchesId,
        this.fromDate,
        this.toDate,
        this.daysCount,
        this.status,
        this.requestNotes,
        this.statusNotes,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.merchantId
      });

  factory ErrandModel.fromJson(Map<String, dynamic> json) =>
      _$ErrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrandModelToJson(this);
}


@JsonSerializable()
class AllErrand {
  Pagination? pagination;

  List<ErrandModel>? missions;

  AllErrand({
    this.pagination,
    this.missions,
  });

  factory AllErrand.fromJson(Map<String, dynamic> json) =>
      _$AllErrandFromJson(json);

  Map<String, dynamic> toJson() => _$AllErrandToJson(this);
}
