// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessTripModel _$BusinessTripModelFromJson(Map<String, dynamic> json) =>
    BusinessTripModel(
      id: (json['id'] as num?)?.toInt(),
      requestDate: json['request_date'] as String?,
      tripType: json['trip_type'] as String?,
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      daysCount: (json['days_count'] as num?)?.toInt(),
      status: json['status'] as String?,
      requestNotes: json['request_notes'] as String?,
      statusNotes: json['status_notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BusinessTripModelToJson(BusinessTripModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'request_date': ?instance.requestDate,
      'trip_type': ?instance.tripType,
      'from_date': ?instance.fromDate,
      'to_date': ?instance.toDate,
      'days_count': ?instance.daysCount,
      'status': ?instance.status,
      'request_notes': ?instance.requestNotes,
      'status_notes': ?instance.statusNotes,
      'created_at': ?instance.createdAt,
      'updated_at': ?instance.updatedAt,
    };

AllBusinessTrips _$AllBusinessTripsFromJson(Map<String, dynamic> json) =>
    AllBusinessTrips(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => BusinessTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllBusinessTripsToJson(AllBusinessTrips instance) =>
    <String, dynamic>{
      'pagination': ?instance.pagination?.toJson(),
      'trips': ?instance.trips?.map((e) => e.toJson()).toList(),
    };
