/// status_code : 200
/// success : true
/// data : {"EmployeeID":"20","EmployeeName":"Hassan","EmployeePhoto":"","OwnerID":"1","EmployeeStatus":"ACTIVE","EmpKey":"+20","EmpPhone":"1159050530"}
/// message : "sucssesfully"
library;

class GetEmployeeModel {
  GetEmployeeModel({
      num? statusCode, 
      bool? success, 
      EmployeeInfoModel? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetEmployeeModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? EmployeeInfoModel.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  EmployeeInfoModel? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  EmployeeInfoModel? get data => _data;
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

/// EmployeeID : "20"
/// EmployeeName : "Hassan"
/// EmployeePhoto : ""
/// OwnerID : "1"
/// EmployeeStatus : "ACTIVE"
/// EmpKey : "+20"
/// EmpPhone : "1159050530"

class EmployeeInfoModel {
  EmployeeInfoModel({
    String? firebaseToken,
    String? token,
    String? canDeleteMost,
      String? employeeID,
    String? canUpdateMost,
      String? employeeName, 
      String? employeePhoto, 
      String? ownerID,
      String? employeeStatus, 
      String? empKey, 
      String? empPhone,
  }){
    _canDeleteMost = canDeleteMost;
    _employeeID = employeeID;
    _employeeName = employeeName;
    _employeePhoto = employeePhoto;
    _canUpdateMost = canUpdateMost;
    _ownerID = ownerID;
    _employeeStatus = employeeStatus;
    _empKey = empKey;

    _empPhone = empPhone;

}

  EmployeeInfoModel.fromJson(dynamic json) {
    _canUpdateMost = json['CanUpdateMost'];
    _canDeleteMost = json['CanDeleteMost'];
    _employeeID = json['EmployeeID'];
    _employeeName = json['EmployeeName'];
    _employeePhoto = json['EmployeePhoto'];
    _ownerID = json['OwnerID'];
    _employeeStatus = json['EmployeeStatus'];
    _empKey = json['EmpKey'];
    _empPhone = json['EmpPhone'];
    _token = json['Token'];
    _firebaseToken = json['FirebaseToken'];
  }
  String? _canDeleteMost;
  String? _employeeID;
  String? _canUpdateMost;
  String? _employeeName;
  String? _employeePhoto;
  String? _ownerID;
  String? _employeeStatus;
  String? _empKey;
  String? _empPhone;
  String? _firebaseToken;
  String? _token;
  String? get canUpdateMost => _canUpdateMost;
  String? get canDeleteMost => _canDeleteMost;
  String? get employeeID => _employeeID;
  String? get employeeName => _employeeName;
  String? get employeePhoto => _employeePhoto;
  String? get ownerID => _ownerID;
  String? get employeeStatus => _employeeStatus;
  String? get empKey => _empKey;
  String? get empPhone => _empPhone;
  String? get token => _token;
  String? get firebaseToken =>  _firebaseToken;
  set empKey(String? value) => _empKey = value;
  set empPhone(String? value) => _empPhone = value;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmployeeID'] = _employeeID;
    map['CanUpdateMost'] = _canUpdateMost;
    map['CanDeleteMost'] = _canDeleteMost;
    map['EmployeeName'] = _employeeName;
    map['EmployeePhoto'] = _employeePhoto;
    map['OwnerID'] = _ownerID;
    map['EmployeeStatus'] = _employeeStatus;
    map['EmpKey'] = _empKey;
    map['EmpPhone'] = _empPhone;
    map['FirebaseToken'] = _firebaseToken;
    map['Token'] = _token;
    return map;
  }
  bool isNotEmpty() {
    return _employeeID != null && _employeeID!.isNotEmpty &&
        _employeeName != null && _employeeName!.isNotEmpty &&
        _empPhone != null && _empPhone!.isNotEmpty;
  }
}