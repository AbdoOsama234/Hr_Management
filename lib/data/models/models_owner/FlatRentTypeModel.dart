/// status_code : 200
/// success : true
/// data : [{"RentTypeID":"1","RentTypeArab":"شهري","RentTypeEng":"Month","RentTypeStatus":"ACTIVE"},{"RentTypeID":"2","RentTypeArab":"سنوي","RentTypeEng":"Year","RentTypeStatus":"ACTIVE"}]
/// message : "sucssesfully"
library;

class FlatRentTypeModel {
  FlatRentTypeModel({
      num? statusCode, 
      bool? success, 
      List<FlatRentTypeInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  FlatRentTypeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FlatRentTypeInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<FlatRentTypeInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<FlatRentTypeInfoModel>? get data => _data;
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

/// RentTypeID : "1"
/// RentTypeArab : "شهري"
/// RentTypeEng : "Month"
/// RentTypeStatus : "ACTIVE"

class FlatRentTypeInfoModel {
  FlatRentTypeInfoModel({
      String? rentTypeID, 
      String? rentTypeArab, 
      String? rentTypeEng, 
      String? rentTypeStatus,}){
    _rentTypeID = rentTypeID;
    _rentTypeArab = rentTypeArab;
    _rentTypeEng = rentTypeEng;
    _rentTypeStatus = rentTypeStatus;
}

  FlatRentTypeInfoModel.fromJson(dynamic json) {
    _rentTypeID = json['RentTypeID'];
    _rentTypeArab = json['RentTypeArab'];
    _rentTypeEng = json['RentTypeEng'];
    _rentTypeStatus = json['RentTypeStatus'];
  }
  String? _rentTypeID;
  String? _rentTypeArab;
  String? _rentTypeEng;
  String? _rentTypeStatus;

  String? get rentTypeID => _rentTypeID;
  String? get rentTypeArab => _rentTypeArab;
  String? get rentTypeEng => _rentTypeEng;
  String? get rentTypeStatus => _rentTypeStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RentTypeID'] = _rentTypeID;
    map['RentTypeArab'] = _rentTypeArab;
    map['RentTypeEng'] = _rentTypeEng;
    map['RentTypeStatus'] = _rentTypeStatus;
    return map;
  }

}