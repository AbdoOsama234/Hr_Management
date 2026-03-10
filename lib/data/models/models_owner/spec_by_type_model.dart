import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// status_code : 200
/// success : true
/// data : [{"FlatTypesSpecificationID":"1","FlatTypesSpecificationArab":"مساحة","FlatTypesSpecificationEng":"Distance","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"},{"FlatTypesSpecificationID":"4","FlatTypesSpecificationArab":"عدد الحجرات","FlatTypesSpecificationEng":"Number of rooms","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"}]
/// message : "sucssesfully"

class SpecByTypeModel {
  SpecByTypeModel({
    num? statusCode,
    bool? success,
    List<SpecByTypeInfo>? data,
    String? message,
  }) {
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
  }

  SpecByTypeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SpecByTypeInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<SpecByTypeInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<SpecByTypeInfo>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

/// FlatTypesSpecificationID : "1"
/// FlatTypesSpecificationArab : "مساحة"
/// FlatTypesSpecificationEng : "Distance"
/// FlatTypesSpecificationStatus : "ACTIVE"
/// FlatTypesID : "1"

// ignore: must_be_immutable
class SpecByTypeInfo extends Equatable {
  @override
  List<Object> get props => [flatTypesSpecificationID ?? ""];

  TextEditingController textEditingController = TextEditingController();
  SpecByTypeInfo({
    String? flatTypesSpecificationID,
    String? flatTypesSpecificationArab,
    String? flatTypesSpecificationEng,
    String? flatTypesSpecificationStatus,
    String? flatTypesID,
  }) {
    _flatTypesSpecificationID = flatTypesSpecificationID;
    _flatTypesSpecificationArab = flatTypesSpecificationArab;
    _flatTypesSpecificationEng = flatTypesSpecificationEng;
    _flatTypesSpecificationStatus = flatTypesSpecificationStatus;
    _flatTypesID = flatTypesID;
  }

  SpecByTypeInfo.fromJson(dynamic json) {
    _flatTypesSpecificationID = json['FlatTypesSpecificationID'];
    _flatTypesSpecificationArab = json['FlatTypesSpecificationArab'];
    _flatTypesSpecificationEng = json['FlatTypesSpecificationEng'];
    _flatTypesSpecificationStatus = json['FlatTypesSpecificationStatus'];
    _flatTypesID = json['FlatTypesID'];
  }
  String? _flatTypesSpecificationID;
  String? _flatTypesSpecificationArab;
  String? _flatTypesSpecificationEng;
  String? _flatTypesSpecificationStatus;
  String? _flatTypesID;

  String? get flatTypesSpecificationID => _flatTypesSpecificationID;
  String? get flatTypesSpecificationArab => _flatTypesSpecificationArab;
  String? get flatTypesSpecificationEng => _flatTypesSpecificationEng;
  String? get flatTypesSpecificationStatus => _flatTypesSpecificationStatus;
  String? get flatTypesID => _flatTypesID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FlatTypesSpecificationID'] = _flatTypesSpecificationID;
    map['FlatTypesSpecificationArab'] = _flatTypesSpecificationArab;
    map['FlatTypesSpecificationEng'] = _flatTypesSpecificationEng;
    map['FlatTypesSpecificationStatus'] = _flatTypesSpecificationStatus;
    map['FlatTypesID'] = _flatTypesID;
    return map;
  }
}
