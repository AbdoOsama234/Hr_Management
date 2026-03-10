/// status_code : 200
/// success : true
/// data : [{"AqarTypeID":"1","AqarTypeNameAr":"عادي","AqarTypeNameEn":"Normal","AqarTypeStatus":"ACTIVE"},{"AqarTypeID":"2","AqarTypeNameAr":"فندق","AqarTypeNameEn":"Hotel","AqarTypeStatus":"ACTIVE"},{"AqarTypeID":"3","AqarTypeNameAr":"مكتب","AqarTypeNameEn":"Office","AqarTypeStatus":"ACTIVE"}]
/// message : "sucssesfully"
library;

class GetAqarTypeModel {
  GetAqarTypeModel({
      num? statusCode, 
      bool? success, 
      List<AqarTypeInfo>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetAqarTypeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AqarTypeInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<AqarTypeInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AqarTypeInfo>? get data => _data;
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

/// AqarTypeID : "1"
/// AqarTypeNameAr : "عادي"
/// AqarTypeNameEn : "Normal"
/// AqarTypeStatus : "ACTIVE"

class AqarTypeInfo {
  AqarTypeInfo({
      String? aqarTypeID, 
      String? aqarTypeNameAr, 
      String? aqarTypeNameEn, 
      String? aqarTypeStatus,}){
    _aqarTypeID = aqarTypeID;
    _aqarTypeNameAr = aqarTypeNameAr;
    _aqarTypeNameEn = aqarTypeNameEn;
    _aqarTypeStatus = aqarTypeStatus;
}

  AqarTypeInfo.fromJson(dynamic json) {
    _aqarTypeID = json['AqarTypeID'];
    _aqarTypeNameAr = json['AqarTypeNameAr'];
    _aqarTypeNameEn = json['AqarTypeNameEn'];
    _aqarTypeStatus = json['AqarTypeStatus'];
  }
  String? _aqarTypeID;
  String? _aqarTypeNameAr;
  String? _aqarTypeNameEn;
  String? _aqarTypeStatus;

  String? get aqarTypeID => _aqarTypeID;
  String? get aqarTypeNameAr => _aqarTypeNameAr;
  String? get aqarTypeNameEn => _aqarTypeNameEn;
  String? get aqarTypeStatus => _aqarTypeStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AqarTypeID'] = _aqarTypeID;
    map['AqarTypeNameAr'] = _aqarTypeNameAr;
    map['AqarTypeNameEn'] = _aqarTypeNameEn;
    map['AqarTypeStatus'] = _aqarTypeStatus;
    return map;
  }

}