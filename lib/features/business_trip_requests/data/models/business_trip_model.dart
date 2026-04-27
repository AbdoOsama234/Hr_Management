import 'package:json_annotation/json_annotation.dart';
import '../../../../data/models/pagination_model.dart';

part 'business_trip_model.g.dart';

/// 🔹 Single Item
@JsonSerializable()
class BusinessTripModel {
  int? id;

  String? requestDate;

  String? tripType;

  String? fromDate;

  String? toDate;

  @JsonKey(fromJson: _toInt)
  int? daysCount;

  String? status;

  String? requestNotes;

  String? statusNotes;

  String? createdAt;

  String? updatedAt;

  BusinessTripModel({
    this.id,
    this.requestDate,
    this.tripType,
    this.fromDate,
    this.toDate,
    this.daysCount,
    this.status,
    this.requestNotes,
    this.statusNotes,
    this.createdAt,
    this.updatedAt,
  });

  factory BusinessTripModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessTripModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessTripModelToJson(this);

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    return int.tryParse(value.toString());
  }
}

/// 🔹 Wrapper (GET)
@JsonSerializable()
class AllBusinessTrips {
  Pagination? pagination;

  @JsonKey(name: "missions")
  List<BusinessTripModel>? trips;

  AllBusinessTrips({this.pagination, this.trips});

  factory AllBusinessTrips.fromJson(Map<String, dynamic> json) =>
      _$AllBusinessTripsFromJson(json);

  Map<String, dynamic> toJson() => _$AllBusinessTripsToJson(this);
}