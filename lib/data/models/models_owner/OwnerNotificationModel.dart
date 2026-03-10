/// status_code : 200
/// success : true
/// data : [{"OwnerNotificationId":"1","NotificationTextArab":"الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم ","NotificationTextEN":"Employee ahmed collected rent 1000 from flat num ","OwnerID":"23","Seen":"SEEN","lastUpdatedNotf":"2025-07-08 11:11:26","CreatedAtNotf":"2025-07-08 09:38:31","FlatID":"2"},{"OwnerNotificationId":"2","NotificationTextArab":"الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم 14","NotificationTextEN":"Employee ahmed collected rent 1000 from flat num 14","OwnerID":"23","Seen":"SEEN","lastUpdatedNotf":"2025-07-08 11:11:26","CreatedAtNotf":"2025-07-08 09:55:06","FlatID":"2"},{"OwnerNotificationId":"3","NotificationTextArab":"الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم 14","NotificationTextEN":"Employee ahmed collected rent 1000 from flat num 14","OwnerID":"23","Seen":"SEEN","lastUpdatedNotf":"2025-07-08 11:11:26","CreatedAtNotf":"2025-07-08 10:11:48","FlatID":"2"}]
/// message : "sucssesfully"
library;

class OwnerNotificationModel {
  OwnerNotificationModel({
      num? statusCode, 
      bool? success, 
      List<OwnerNotificationInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  OwnerNotificationModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OwnerNotificationInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<OwnerNotificationInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<OwnerNotificationInfoModel>? get data => _data;
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

/// OwnerNotificationId : "1"
/// NotificationTextArab : "الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم "
/// NotificationTextEN : "Employee ahmed collected rent 1000 from flat num "
/// OwnerID : "23"
/// Seen : "SEEN"
/// lastUpdatedNotf : "2025-07-08 11:11:26"
/// CreatedAtNotf : "2025-07-08 09:38:31"
/// FlatID : "2"

class OwnerNotificationInfoModel {
  OwnerNotificationInfoModel({
      String? ownerNotificationId, 
      String? notificationTextArab, 
      String? notificationTextEN, 
      String? ownerID, 
      String? seen, 
      String? lastUpdatedNotf, 
      String? createdAtNotf, 
      String? flatID,}){
    _ownerNotificationId = ownerNotificationId;
    _notificationTextArab = notificationTextArab;
    _notificationTextEN = notificationTextEN;
    _ownerID = ownerID;
    _seen = seen;
    _lastUpdatedNotf = lastUpdatedNotf;
    _createdAtNotf = createdAtNotf;
    _flatID = flatID;
}

  OwnerNotificationInfoModel.fromJson(dynamic json) {
    _ownerNotificationId = json['OwnerNotificationId'];
    _notificationTextArab = json['NotificationTextArab'];
    _notificationTextEN = json['NotificationTextEN'];
    _ownerID = json['OwnerID'];
    _seen = json['Seen'];
    _lastUpdatedNotf = json['lastUpdatedNotf'];
    _createdAtNotf = json['CreatedAtNotf'];
    _flatID = json['FlatID'];
  }
  String? _ownerNotificationId;
  String? _notificationTextArab;
  String? _notificationTextEN;
  String? _ownerID;
  String? _seen;
  String? _lastUpdatedNotf;
  String? _createdAtNotf;
  String? _flatID;

  String? get ownerNotificationId => _ownerNotificationId;
  String? get notificationTextArab => _notificationTextArab;
  String? get notificationTextEN => _notificationTextEN;
  String? get ownerID => _ownerID;
  String? get seen => _seen;
  String? get lastUpdatedNotf => _lastUpdatedNotf;
  String? get createdAtNotf => _createdAtNotf;
  String? get flatID => _flatID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OwnerNotificationId'] = _ownerNotificationId;
    map['NotificationTextArab'] = _notificationTextArab;
    map['NotificationTextEN'] = _notificationTextEN;
    map['OwnerID'] = _ownerID;
    map['Seen'] = _seen;
    map['lastUpdatedNotf'] = _lastUpdatedNotf;
    map['CreatedAtNotf'] = _createdAtNotf;
    map['FlatID'] = _flatID;
    return map;
  }

}