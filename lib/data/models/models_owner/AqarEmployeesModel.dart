/// status_code : 200
/// success : true
/// data : [{"EmployeeID":"2","EmployeeName":"emad","EmployeePhoto":"","OwnerID":"1","EmployeeStatus":"ACTIVE","EmpKey":"","EmpPhone":"","Token":"","FirebaseToken":"","Balance":"1800","lastUpdatedEmployee":"2025-07-16 14:38:09","CreatedAtEmployee":"2025-07-16 14:38:09","AqarAndEmployeesID":"4","AqarID":"2","AqarAndEmployeesStatus":"ACTIVE","lastUpdatedAqarAndEmployees":"2025-07-29 11:08:55","CreatedAtAqarAndEmployees":"2025-07-29 11:08:55"},{"EmployeeID":"1","EmployeeName":"Hassan","EmployeePhoto":"https://engaztechnology.net/aqaratyAPI/Employee/CompanyLogoImages/CompanyLogoImages-583080.png","OwnerID":"1","EmployeeStatus":"ACTIVE","EmpKey":"+20","EmpPhone":"1159050530","Token":"","FirebaseToken":"efZ3m2CFRNeJ7uzJOxnymi:APA91bG-LhmyukW-OlQgAji55q3YfvFrcBqj8bgQWa7keziQOszQIMmNfAH6w5fvwRA2cmqQ4mLZGV59gerk102GpT98gkTV2xKOW_-eV2pdxeBn2C907D4","Balance":"2","lastUpdatedEmployee":"2025-07-29 10:23:51","CreatedAtEmployee":"2025-07-16 14:38:09","AqarAndEmployeesID":"3","AqarID":"2","AqarAndEmployeesStatus":"PASTEMP","lastUpdatedAqarAndEmployees":"2025-07-29 11:08:55","CreatedAtAqarAndEmployees":"2025-07-29 11:08:13"},{"EmployeeID":"1","EmployeeName":"Hassan","EmployeePhoto":"https://engaztechnology.net/aqaratyAPI/Employee/CompanyLogoImages/CompanyLogoImages-583080.png","OwnerID":"1","EmployeeStatus":"ACTIVE","EmpKey":"+20","EmpPhone":"1159050530","Token":"","FirebaseToken":"efZ3m2CFRNeJ7uzJOxnymi:APA91bG-LhmyukW-OlQgAji55q3YfvFrcBqj8bgQWa7keziQOszQIMmNfAH6w5fvwRA2cmqQ4mLZGV59gerk102GpT98gkTV2xKOW_-eV2pdxeBn2C907D4","Balance":"2","lastUpdatedEmployee":"2025-07-29 10:23:51","CreatedAtEmployee":"2025-07-16 14:38:09","AqarAndEmployeesID":"1","AqarID":"2","AqarAndEmployeesStatus":"PASTEMP","lastUpdatedAqarAndEmployees":"2025-07-29 09:59:14","CreatedAtAqarAndEmployees":"2025-07-29 09:59:06"},{"EmployeeID":"2","EmployeeName":"emad","EmployeePhoto":"","OwnerID":"1","EmployeeStatus":"ACTIVE","EmpKey":"","EmpPhone":"","Token":"","FirebaseToken":"","Balance":"1800","lastUpdatedEmployee":"2025-07-16 14:38:09","CreatedAtEmployee":"2025-07-16 14:38:09","AqarAndEmployeesID":"2","AqarID":"2","AqarAndEmployeesStatus":"PASTEMP","lastUpdatedAqarAndEmployees":"2025-07-29 11:08:13","CreatedAtAqarAndEmployees":"2025-07-29 09:59:14"}]
/// message : "sucssesfully"
library;

class AqarEmployeesModel {
  AqarEmployeesModel({
      num? statusCode, 
      bool? success, 
      List<AqarEmployeesInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  AqarEmployeesModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AqarEmployeesInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<AqarEmployeesInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AqarEmployeesInfoModel>? get data => _data;
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

/// EmployeeID : "2"
/// EmployeeName : "emad"
/// EmployeePhoto : ""
/// OwnerID : "1"
/// EmployeeStatus : "ACTIVE"
/// EmpKey : ""
/// EmpPhone : ""
/// Token : ""
/// FirebaseToken : ""
/// Balance : "1800"
/// lastUpdatedEmployee : "2025-07-16 14:38:09"
/// CreatedAtEmployee : "2025-07-16 14:38:09"
/// AqarAndEmployeesID : "4"
/// AqarID : "2"
/// AqarAndEmployeesStatus : "ACTIVE"
/// lastUpdatedAqarAndEmployees : "2025-07-29 11:08:55"
/// CreatedAtAqarAndEmployees : "2025-07-29 11:08:55"

class AqarEmployeesInfoModel {
  AqarEmployeesInfoModel({
      String? employeeID, 
      String? employeeName, 
      String? employeePhoto, 
      String? ownerID, 
      String? employeeStatus, 
      String? empKey, 
      String? empPhone, 
      String? token, 
      String? firebaseToken, 
      String? balance, 
      String? lastUpdatedEmployee, 
      String? createdAtEmployee, 
      String? aqarAndEmployeesID, 
      String? aqarID, 
      String? aqarAndEmployeesStatus, 
      String? lastUpdatedAqarAndEmployees, 
      String? createdAtAqarAndEmployees,}){
    _employeeID = employeeID;
    _employeeName = employeeName;
    _employeePhoto = employeePhoto;
    _ownerID = ownerID;
    _employeeStatus = employeeStatus;
    _empKey = empKey;
    _empPhone = empPhone;
    _token = token;
    _firebaseToken = firebaseToken;
    _balance = balance;
    _lastUpdatedEmployee = lastUpdatedEmployee;
    _createdAtEmployee = createdAtEmployee;
    _aqarAndEmployeesID = aqarAndEmployeesID;
    _aqarID = aqarID;
    _aqarAndEmployeesStatus = aqarAndEmployeesStatus;
    _lastUpdatedAqarAndEmployees = lastUpdatedAqarAndEmployees;
    _createdAtAqarAndEmployees = createdAtAqarAndEmployees;
}

  AqarEmployeesInfoModel.fromJson(dynamic json) {
    _employeeID = json['EmployeeID'];
    _employeeName = json['EmployeeName'];
    _employeePhoto = json['EmployeePhoto'];
    _ownerID = json['OwnerID'];
    _employeeStatus = json['EmployeeStatus'];
    _empKey = json['EmpKey'];
    _empPhone = json['EmpPhone'];
    _token = json['Token'];
    _firebaseToken = json['FirebaseToken'];
    _balance = json['Balance'];
    _lastUpdatedEmployee = json['lastUpdatedEmployee'];
    _createdAtEmployee = json['CreatedAtEmployee'];
    _aqarAndEmployeesID = json['AqarAndEmployeesID'];
    _aqarID = json['AqarID'];
    _aqarAndEmployeesStatus = json['AqarAndEmployeesStatus'];
    _lastUpdatedAqarAndEmployees = json['lastUpdatedAqarAndEmployees'];
    _createdAtAqarAndEmployees = json['CreatedAtAqarAndEmployees'];
  }
  String? _employeeID;
  String? _employeeName;
  String? _employeePhoto;
  String? _ownerID;
  String? _employeeStatus;
  String? _empKey;
  String? _empPhone;
  String? _token;
  String? _firebaseToken;
  String? _balance;
  String? _lastUpdatedEmployee;
  String? _createdAtEmployee;
  String? _aqarAndEmployeesID;
  String? _aqarID;
  String? _aqarAndEmployeesStatus;
  String? _lastUpdatedAqarAndEmployees;
  String? _createdAtAqarAndEmployees;

  String? get employeeID => _employeeID;
  String? get employeeName => _employeeName;
  String? get employeePhoto => _employeePhoto;
  String? get ownerID => _ownerID;
  String? get employeeStatus => _employeeStatus;
  String? get empKey => _empKey;
  String? get empPhone => _empPhone;
  String? get token => _token;
  String? get firebaseToken => _firebaseToken;
  String? get balance => _balance;
  String? get lastUpdatedEmployee => _lastUpdatedEmployee;
  String? get createdAtEmployee => _createdAtEmployee;
  String? get aqarAndEmployeesID => _aqarAndEmployeesID;
  String? get aqarID => _aqarID;
  String? get aqarAndEmployeesStatus => _aqarAndEmployeesStatus;
  String? get lastUpdatedAqarAndEmployees => _lastUpdatedAqarAndEmployees;
  String? get createdAtAqarAndEmployees => _createdAtAqarAndEmployees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmployeeID'] = _employeeID;
    map['EmployeeName'] = _employeeName;
    map['EmployeePhoto'] = _employeePhoto;
    map['OwnerID'] = _ownerID;
    map['EmployeeStatus'] = _employeeStatus;
    map['EmpKey'] = _empKey;
    map['EmpPhone'] = _empPhone;
    map['Token'] = _token;
    map['FirebaseToken'] = _firebaseToken;
    map['Balance'] = _balance;
    map['lastUpdatedEmployee'] = _lastUpdatedEmployee;
    map['CreatedAtEmployee'] = _createdAtEmployee;
    map['AqarAndEmployeesID'] = _aqarAndEmployeesID;
    map['AqarID'] = _aqarID;
    map['AqarAndEmployeesStatus'] = _aqarAndEmployeesStatus;
    map['lastUpdatedAqarAndEmployees'] = _lastUpdatedAqarAndEmployees;
    map['CreatedAtAqarAndEmployees'] = _createdAtAqarAndEmployees;
    return map;
  }

}