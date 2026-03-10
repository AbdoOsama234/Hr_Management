/// status_code : 200
/// success : true
/// data : "-1078"
/// message : "sucssesfully"
library;

class EmployeeWalletTotalModel {
  EmployeeWalletTotalModel({
      num? statusCode, 
      bool? success, 
      String? data, 
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  EmployeeWalletTotalModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'];
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  String? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  String? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['success'] = _success;
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }

}