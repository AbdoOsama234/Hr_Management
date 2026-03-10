/// status_code : 200
/// success : true
/// otpCode : 123456
/// message : "Sent sucssesfully"
library;

class WhatsappOTPModel {
  WhatsappOTPModel({
      int? statusCode,
      bool? success, 
      int? otpCode,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _otpCode = otpCode;
    _message = message;
}

  WhatsappOTPModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _otpCode = json['data'];
    _message = json['message'];
  }
  int? _statusCode;
  bool? _success;
  int? _otpCode;
  String? _message;

  int? get statusCode => _statusCode;
  bool? get success => _success;
  int? get otpCode => _otpCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['success'] = _success;
    map['data'] = _otpCode;
    map['message'] = _message;
    return map;
  }

}