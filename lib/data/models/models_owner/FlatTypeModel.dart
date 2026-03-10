/// status_code : 200
/// success : true
/// data : [{"FlatTypesID":"1","FlatTypesArab":"مكتب","FlatTypesEng":"Office","FlatTypesStatus":"ACTIVE"},{"FlatTypesID":"2","FlatTypesArab":"شقة","FlatTypesEng":"Flat","FlatTypesStatus":"ACTIVE"},{"FlatTypesID":"3","FlatTypesArab":"استوديو","FlatTypesEng":"Studio","FlatTypesStatus":"ACTIVE"}]
/// message : "sucssesfully"
library;

class FlatTypeModel {
  FlatTypeModel({
      num? statusCode, 
      bool? success, 
      List<FlatTypeInfo>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  FlatTypeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FlatTypeInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<FlatTypeInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<FlatTypeInfo>? get data => _data;
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

/// FlatTypesID : "1"
/// FlatTypesArab : "مكتب"
/// FlatTypesEng : "Office"
/// FlatTypesStatus : "ACTIVE"

class FlatTypeInfo {
  FlatTypeInfo({
      String? flatTypesID, 
      String? flatTypesArab, 
      String? flatTypesEng, 
      String? flatTypesStatus,}){
    _flatTypesID = flatTypesID;
    _flatTypesArab = flatTypesArab;
    _flatTypesEng = flatTypesEng;
    _flatTypesStatus = flatTypesStatus;
}

  FlatTypeInfo.fromJson(dynamic json) {
    _flatTypesID = json['FlatTypesID'];
    _flatTypesArab = json['FlatTypesArab'];
    _flatTypesEng = json['FlatTypesEng'];
    _flatTypesStatus = json['FlatTypesStatus'];
  }
  String? _flatTypesID;
  String? _flatTypesArab;
  String? _flatTypesEng;
  String? _flatTypesStatus;

  String? get flatTypesID => _flatTypesID;
  String? get flatTypesArab => _flatTypesArab;
  String? get flatTypesEng => _flatTypesEng;
  String? get flatTypesStatus => _flatTypesStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FlatTypesID'] = _flatTypesID;
    map['FlatTypesArab'] = _flatTypesArab;
    map['FlatTypesEng'] = _flatTypesEng;
    map['FlatTypesStatus'] = _flatTypesStatus;
    return map;
  }

}