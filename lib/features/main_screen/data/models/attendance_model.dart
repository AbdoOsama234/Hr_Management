import 'package:json_annotation/json_annotation.dart';
part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel {
  int? id;
  int? companyId;
  int? employeesId;
  int? employeesShiftsId;
  String? date;
  String? firstIn;
  String? lastOut;
  int? totalWorkMinutes;
  int? lateMinutes;
  int? earlyLeaveMinutes;
  int? overtimeMinutes;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? firstOut;
  String? secondIn;
  String? merchantId;

  AttendanceModel(
      {this.id,
        this.companyId,
        this.employeesId,
        this.employeesShiftsId,
        this.date,
        this.firstIn,
        this.lastOut,
        this.totalWorkMinutes,
        this.lateMinutes,
        this.earlyLeaveMinutes,
        this.overtimeMinutes,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.firstOut,
        this.secondIn,
        this.merchantId});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}