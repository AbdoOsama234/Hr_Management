import 'package:json_annotation/json_annotation.dart';
import '../../../../data/models/pagination_model.dart';

part 'my_mission_model.g.dart';

/// 🔹 Single Task Item
@JsonSerializable()
class MyMissionModel {
  int? id;
  String? sr;
  String? subject;
  String? status;
  String? date;
  String? desc;
  int? customerId;
  int? contactId;
  int? assignTo;
  int? companyId;
  int? sectionId;
  int? priorityId;
  String? link;
  String? file;
  String? dueDate;
  String? startDate;
  String? endDate;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  int? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? position;
  int? taskStatusId;
  int? teamId;
  int? merchantId;

  MyMissionModel(
      {this.id,
        this.sr,
        this.subject,
        this.status,
        this.date,
        this.desc,
        this.customerId,
        this.contactId,
        this.assignTo,
        this.companyId,
        this.sectionId,
        this.priorityId,
        this.link,
        this.file,
        this.dueDate,
        this.startDate,
        this.endDate,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.position,
        this.taskStatusId,
        this.teamId,
        this.merchantId});

  factory MyMissionModel.fromJson(Map<String, dynamic> json) =>
      _$MyMissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyMissionModelToJson(this);
}

/// 🔹 Wrapper (GET all)
@JsonSerializable()
class AllMyMissions {
  Pagination? pagination;
  List<MyMissionModel>? tasks;

  AllMyMissions({this.pagination, this.tasks});

  factory AllMyMissions.fromJson(Map<String, dynamic> json) =>
      _$AllMyMissionsFromJson(json);

  Map<String, dynamic> toJson() => _$AllMyMissionsToJson(this);
}
