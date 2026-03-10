/// status_code : 200
/// success : true
/// message : "Done ya ali"
library;

class CollectMoneyFromEmployeeModel {
  CollectMoneyFromEmployeeModel({
      num? statusCode, 
      bool? success, 
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _message = message;
}

  CollectMoneyFromEmployeeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}