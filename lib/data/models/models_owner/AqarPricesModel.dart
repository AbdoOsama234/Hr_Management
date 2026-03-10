/// status_code : 200
/// success : true
/// data : {"PricesID":"1","AqarPrice":"50","Dareba":"10","Service":"6"}
/// message : "sucssesfully"
library;

class AqarPricesModel {
  AqarPricesModel({
      num? statusCode, 
      bool? success, 
      AqarPricesInfoModel? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  AqarPricesModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? AqarPricesInfoModel.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  AqarPricesInfoModel? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  AqarPricesInfoModel? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// PricesID : "1"
/// AqarPrice : "50"
/// Dareba : "10"
/// Service : "6"

class AqarPricesInfoModel {
  AqarPricesInfoModel({
      String? pricesID, 
      String? aqarPrice, 
      String? dareba, 
      String? service,}){
    _pricesID = pricesID;
    _aqarPrice = aqarPrice;
    _dareba = dareba;
    _service = service;
}

  AqarPricesInfoModel.fromJson(dynamic json) {
    _pricesID = json['PricesID'];
    _aqarPrice = json['AqarPrice'];
    _dareba = json['Dareba'];
    _service = json['Service'];
  }
  String? _pricesID;
  String? _aqarPrice;
  String? _dareba;
  String? _service;

  String? get pricesID => _pricesID;
  String? get aqarPrice => _aqarPrice;
  String? get dareba => _dareba;
  String? get service => _service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PricesID'] = _pricesID;
    map['AqarPrice'] = _aqarPrice;
    map['Dareba'] = _dareba;
    map['Service'] = _service;
    return map;
  }

}