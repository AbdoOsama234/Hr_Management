/// status_code : 200
/// success : true
/// data : {"OwnerStatus":"PENDING"}
/// message : "sucssesfully"
library;

// class GetOwnerInfoModel {
//   GetOwnerInfoModel({
//       num? statusCode,
//       bool? success,
//       GetOwnerInfo? data,
//       String? message,}){
//     _statusCode = statusCode;
//     _success = success;
//     _data = data;
//     _message = message;
// }
//
//   GetOwnerInfoModel.fromJson(dynamic json) {
//     _statusCode = json['status_code'];
//     _success = json['success'];
//     _data = json['data'] != null ? GetOwnerInfo.fromJson(json['data']) : null;
//     _message = json['message'];
//   }
//   num? _statusCode;
//   bool? _success;
//   GetOwnerInfo? _data;
//   String? _message;
//
//   num? get statusCode => _statusCode;
//   bool? get success => _success;
//   GetOwnerInfo? get data => _data;
//   String? get message => _message;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status_code'] = _statusCode;
//     map['success'] = _success;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     map['message'] = _message;
//     return map;
//   }
//
// }

/// OwnerStatus : "PENDING"

class GetOwnerInfoModel {
  GetOwnerInfoModel({String? ownerStatus}){
    _ownerStatus = ownerStatus;
}

  GetOwnerInfoModel.fromJson(dynamic json) {
    _ownerStatus = json['OwnerStatus'];
  }
  String? _ownerStatus;

  String? get ownerStatus => _ownerStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OwnerStatus'] = _ownerStatus;
    return map;
  }

}