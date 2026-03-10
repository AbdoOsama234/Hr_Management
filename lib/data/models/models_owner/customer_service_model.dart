/// status_code : 200
/// success : true
/// data : [{"CustomerServiceID":"1","Email":"a@y.com","Phone":"+201159050530","Wats":"+201116310853"}]
/// message : "sucssesfully"
library;

class CustomerServiceModel {
  CustomerServiceModel({
      num? statusCode, 
      bool? success, 
      List<CustomerServiceInfo>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  CustomerServiceModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CustomerServiceInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<CustomerServiceInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<CustomerServiceInfo>? get data => _data;
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

/// CustomerServiceID : "1"
/// Email : "a@y.com"
/// Phone : "+201159050530"
/// Wats : "+201116310853"

class CustomerServiceInfo {
  CustomerServiceInfo({
      String? customerServiceID, 
      String? email, 
      String? phone, 
      String? wats,}){
    _customerServiceID = customerServiceID;
    _email = email;
    _phone = phone;
    _wats = wats;
}

  CustomerServiceInfo.fromJson(dynamic json) {
    _customerServiceID = json['CustomerServiceID'];
    _email = json['Email'];
    _phone = json['Phone'];
    _wats = json['Wats'];
  }
  String? _customerServiceID;
  String? _email;
  String? _phone;
  String? _wats;

  String? get customerServiceID => _customerServiceID;
  String? get email => _email;
  String? get phone => _phone;
  String? get wats => _wats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerServiceID'] = _customerServiceID;
    map['Email'] = _email;
    map['Phone'] = _phone;
    map['Wats'] = _wats;
    return map;
  }

}