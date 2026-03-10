/// status_code : 200
/// success : true
/// data : [{"count(*)":"0"}]
/// message : "sucssesfully"
library;

class NotificationNotSeenCountModel {
  NotificationNotSeenCountModel({
      num? statusCode, 
      bool? success, 
      List<NotificationNotSeenCountInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  NotificationNotSeenCountModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationNotSeenCountInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<NotificationNotSeenCountInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<NotificationNotSeenCountInfoModel>? get data => _data;
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

/// count(*) : "0"

class NotificationNotSeenCountInfoModel {
  NotificationNotSeenCountInfoModel({
      String? count,}){
    _count = count;
}

  NotificationNotSeenCountInfoModel.fromJson(dynamic json) {
    _count = json['count(*)'];
  }
  String? _count;

  String? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count(*)'] = _count;
    return map;
  }

}