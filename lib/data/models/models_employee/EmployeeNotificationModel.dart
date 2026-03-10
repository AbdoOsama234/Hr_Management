/// status_code : 200
/// success : true
/// data : [{"EmpNotificationID":"1","EmployeeID":"17","NotificationTextEN":"Employee ahmed collected rent 1000 from flat num 14","NotificationTextAR":"الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم 14","Seen":"SEEN","FlatID":"2","lastUpdatedEmpNotification":"2025-07-08 10:18:32","CreatedAtEmpNotification":"2025-07-08 10:11:48"}]
/// message : "sucssesfully"
library;

class EmployeeNotificationModel {
  EmployeeNotificationModel({
      num? statusCode, 
      bool? success, 
      List<EmployeeNotificationInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  EmployeeNotificationModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EmployeeNotificationInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<EmployeeNotificationInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<EmployeeNotificationInfoModel>? get data => _data;
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

/// EmpNotificationID : "1"
/// EmployeeID : "17"
/// NotificationTextEN : "Employee ahmed collected rent 1000 from flat num 14"
/// NotificationTextAR : "الموظف ahmed جمع الايجار بمبلغ  1000 ريال  من شقة رقم 14"
/// Seen : "SEEN"
/// FlatID : "2"
/// lastUpdatedEmpNotification : "2025-07-08 10:18:32"
/// CreatedAtEmpNotification : "2025-07-08 10:11:48"

class EmployeeNotificationInfoModel {
  EmployeeNotificationInfoModel({
      String? empNotificationID, 
      String? employeeID, 
      String? notificationTextEN, 
      String? notificationTextAR, 
      String? seen, 
      String? flatID, 
      String? lastUpdatedEmpNotification, 
      String? createdAtEmpNotification,}){
    _empNotificationID = empNotificationID;
    _employeeID = employeeID;
    _notificationTextEN = notificationTextEN;
    _notificationTextAR = notificationTextAR;
    _seen = seen;
    _flatID = flatID;
    _lastUpdatedEmpNotification = lastUpdatedEmpNotification;
    _createdAtEmpNotification = createdAtEmpNotification;
}

  EmployeeNotificationInfoModel.fromJson(dynamic json) {
    _empNotificationID = json['EmpNotificationID'];
    _employeeID = json['EmployeeID'];
    _notificationTextEN = json['NotificationTextEN'];
    _notificationTextAR = json['NotificationTextAR'];
    _seen = json['Seen'];
    _flatID = json['FlatID'];
    _lastUpdatedEmpNotification = json['lastUpdatedEmpNotification'];
    _createdAtEmpNotification = json['CreatedAtEmpNotification'];
  }
  String? _empNotificationID;
  String? _employeeID;
  String? _notificationTextEN;
  String? _notificationTextAR;
  String? _seen;
  String? _flatID;
  String? _lastUpdatedEmpNotification;
  String? _createdAtEmpNotification;

  String? get empNotificationID => _empNotificationID;
  String? get employeeID => _employeeID;
  String? get notificationTextEN => _notificationTextEN;
  String? get notificationTextAR => _notificationTextAR;
  String? get seen => _seen;
  String? get flatID => _flatID;
  String? get lastUpdatedEmpNotification => _lastUpdatedEmpNotification;
  String? get createdAtEmpNotification => _createdAtEmpNotification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmpNotificationID'] = _empNotificationID;
    map['EmployeeID'] = _employeeID;
    map['NotificationTextEN'] = _notificationTextEN;
    map['NotificationTextAR'] = _notificationTextAR;
    map['Seen'] = _seen;
    map['FlatID'] = _flatID;
    map['lastUpdatedEmpNotification'] = _lastUpdatedEmpNotification;
    map['CreatedAtEmpNotification'] = _createdAtEmpNotification;
    return map;
  }

}