import 'package:json_annotation/json_annotation.dart';

part 'business_trip_request.g.dart';

@JsonSerializable()
class BusinessTripRequest {
  String? tripType;

  String? fromDate;

  String? toDate;

  int? daysCount;

  String? requestNotes;

  String? statusNotes;

  BusinessTripRequest({
    this.tripType,
    this.fromDate,
    this.toDate,
    this.daysCount,
    this.requestNotes,
    this.statusNotes,
  });

  factory BusinessTripRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessTripRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessTripRequestToJson(this);
}