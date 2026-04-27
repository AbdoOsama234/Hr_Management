// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_trip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessTripRequest _$BusinessTripRequestFromJson(Map<String, dynamic> json) =>
    BusinessTripRequest(
      tripType: json['trip_type'] as String?,
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      daysCount: (json['days_count'] as num?)?.toInt(),
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
    );

Map<String, dynamic> _$BusinessTripRequestToJson(
  BusinessTripRequest instance,
) => <String, dynamic>{
  'trip_type': ?instance.tripType,
  'from_date': ?instance.fromDate,
  'to_date': ?instance.toDate,
  'days_count': ?instance.daysCount,
  'request_notes': ?instance.requestNotes,
  'status_notes': ?instance.statusNotes,
};
