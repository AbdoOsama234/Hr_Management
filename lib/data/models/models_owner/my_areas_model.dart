/// status_code : 200
/// success : true
/// data : [{"AreaID":"1","AreaStatus":"ACTIVE","AreaName":"ryad"},{"AreaID":"2","AreaStatus":"ACTIVE","AreaName":"Gadda"}]
/// message : "sucssesfully"
library;

class MyAreasModel {
  MyAreasModel({
      num? statusCode, 
      bool? success, 
      List<AreaData>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  MyAreasModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AreaData.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<AreaData>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AreaData>? get data => _data;
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

/// AreaID : "1"
/// AreaStatus : "ACTIVE"
/// AreaName : "ryad"

class AreaData {
  AreaData({
      String? areaID, 
      String? areaStatus, 
      String? areaName,}){
    _areaID = areaID;
    _areaStatus = areaStatus;
    _areaName = areaName;
}

  AreaData.fromJson(dynamic json) {
    _areaID = json['AreaID'];
    _areaStatus = json['AreaStatus'];
    _areaName = json['AreaName'];
  }
  String? _areaID;
  String? _areaStatus;
  String? _areaName;

  String? get areaID => _areaID;
  String? get areaStatus => _areaStatus;
  String? get areaName => _areaName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AreaID'] = _areaID;
    map['AreaStatus'] = _areaStatus;
    map['AreaName'] = _areaName;
    return map;
  }

}