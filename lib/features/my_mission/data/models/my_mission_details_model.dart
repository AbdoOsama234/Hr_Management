import 'package:json_annotation/json_annotation.dart';

part 'my_mission_details_model.g.dart';

/// 🔹 Task Details
@JsonSerializable()
class MyMissionDetailsModel {
  int? id;
  String? sr;
  String? subject;
  String? status;
  String? date;
  String? desc;
  String? customerId;
  String? contactId;
  int? assignTo;
  int? companyId;
  String? sectionId;
  int? priorityId;
  String? link;
  String? file;
  String? dueDate;
  String? startDate;
  String? endDate;
  int? position;
  int? taskStatusId;
  int? teamId;
  int? merchantId;
  String? createdAt;

  MyMissionDetailsModel(
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
        this.position,
        this.taskStatusId,
        this.teamId,
        this.merchantId,
        this.createdAt
      });

  factory MyMissionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MyMissionDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyMissionDetailsModelToJson(this);
}
