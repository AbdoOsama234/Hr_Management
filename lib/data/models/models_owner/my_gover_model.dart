/// status_code : 200
/// success : true
/// data : [{"GoverID":"1","GoverStatus":"ACTIVE","AreaID":"1","GoverName":"Karg"},{"GoverID":"2","GoverStatus":"ACTIVE","AreaID":"1","GoverName":"El dwadmy"}]
/// message : "sucssesfully"
library;

class MyGoverModel {
  MyGoverModel({
      num? statusCode, 
      bool? success, 
      List<GoverDataModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  MyGoverModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GoverDataModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<GoverDataModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<GoverDataModel>? get data => _data;
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

/// GoverID : "1"
/// GoverStatus : "ACTIVE"
/// AreaID : "1"
/// GoverName : "Karg"

class GoverDataModel {
  GoverDataModel({
      String? goverID, 
      String? goverStatus, 
      String? areaID, 
      String? goverName,}){
    _goverID = goverID;
    _goverStatus = goverStatus;
    _areaID = areaID;
    _goverName = goverName;
}

  GoverDataModel.fromJson(dynamic json) {
    _goverID = json['GoverID'];
    _goverStatus = json['GoverStatus'];
    _areaID = json['AreaID'];
    _goverName = json['GoverName'];
  }
  String? _goverID;
  String? _goverStatus;
  String? _areaID;
  String? _goverName;

  String? get goverID => _goverID;
  String? get goverStatus => _goverStatus;
  String? get areaID => _areaID;
  String? get goverName => _goverName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GoverID'] = _goverID;
    map['GoverStatus'] = _goverStatus;
    map['AreaID'] = _areaID;
    map['GoverName'] = _goverName;
    return map;
  }

}