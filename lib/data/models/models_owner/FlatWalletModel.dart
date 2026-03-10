/// status_code : 200
/// success : true
/// data : [{"EmployeeWalletID":"1","EmployeeID":"17","TitleAR":"تجميع ايجار","TitleEn":"Collect rental","TextAR":"تجميع ايجار من شقة رقم ","TextEn":" Collection of rent for flat num ","Money":"1000","Type":"MINUS","lastUpdatedEmployeeWallet":"2025-07-08 09:55:19","CreatedAtEmployeeWallet":"2025-07-08 09:38:31","FlatID":"2"},{"EmployeeWalletID":"2","EmployeeID":"17","TitleAR":"تجميع ايجار","TitleEn":"Collect rental","TextAR":"تجميع ايجار من شقة رقم 14","TextEn":" Collection of rent for flat num 14","Money":"1000","Type":"MINUS","lastUpdatedEmployeeWallet":"2025-07-08 09:55:06","CreatedAtEmployeeWallet":"2025-07-08 09:55:06","FlatID":"2"},{"EmployeeWalletID":"3","EmployeeID":"17","TitleAR":"تجميع ايجار","TitleEn":"Collect rental","TextAR":"تجميع ايجار من شقة رقم 14","TextEn":" Collection of rent for flat num 14","Money":"1000","Type":"MINUS","lastUpdatedEmployeeWallet":"2025-07-08 10:11:48","CreatedAtEmployeeWallet":"2025-07-08 10:11:48","FlatID":"2"}]
/// message : "sucssesfully"
library;

class FlatWalletModel {
  FlatWalletModel({
      num? statusCode, 
      bool? success, 
      List<FlatWalletInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  FlatWalletModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FlatWalletInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<FlatWalletInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<FlatWalletInfoModel>? get data => _data;
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

/// EmployeeWalletID : "1"
/// EmployeeID : "17"
/// TitleAR : "تجميع ايجار"
/// TitleEn : "Collect rental"
/// TextAR : "تجميع ايجار من شقة رقم "
/// TextEn : " Collection of rent for flat num "
/// Money : "1000"
/// Type : "MINUS"
/// lastUpdatedEmployeeWallet : "2025-07-08 09:55:19"
/// CreatedAtEmployeeWallet : "2025-07-08 09:38:31"
/// FlatID : "2"

class FlatWalletInfoModel {
  FlatWalletInfoModel({
      String? employeeWalletID, 
      String? employeeID, 
      String? titleAR, 
      String? titleEn, 
      String? textAR, 
      String? textEn, 
      String? money, 
      String? type, 
      String? lastUpdatedEmployeeWallet, 
      String? createdAtEmployeeWallet, 
      String? flatID,}){
    _employeeWalletID = employeeWalletID;
    _employeeID = employeeID;
    _titleAR = titleAR;
    _titleEn = titleEn;
    _textAR = textAR;
    _textEn = textEn;
    _money = money;
    _type = type;
    _lastUpdatedEmployeeWallet = lastUpdatedEmployeeWallet;
    _createdAtEmployeeWallet = createdAtEmployeeWallet;
    _flatID = flatID;
}

  FlatWalletInfoModel.fromJson(dynamic json) {
    _employeeWalletID = json['EmployeeWalletID'];
    _employeeID = json['EmployeeID'];
    _titleAR = json['TitleAR'];
    _titleEn = json['TitleEn'];
    _textAR = json['TextAR'];
    _textEn = json['TextEn'];
    _money = json['Money'];
    _type = json['Type'];
    _lastUpdatedEmployeeWallet = json['lastUpdatedEmployeeWallet'];
    _createdAtEmployeeWallet = json['CreatedAtEmployeeWallet'];
    _flatID = json['FlatID'];
  }
  String? _employeeWalletID;
  String? _employeeID;
  String? _titleAR;
  String? _titleEn;
  String? _textAR;
  String? _textEn;
  String? _money;
  String? _type;
  String? _lastUpdatedEmployeeWallet;
  String? _createdAtEmployeeWallet;
  String? _flatID;

  String? get employeeWalletID => _employeeWalletID;
  String? get employeeID => _employeeID;
  String? get titleAR => _titleAR;
  String? get titleEn => _titleEn;
  String? get textAR => _textAR;
  String? get textEn => _textEn;
  String? get money => _money;
  String? get type => _type;
  String? get lastUpdatedEmployeeWallet => _lastUpdatedEmployeeWallet;
  String? get createdAtEmployeeWallet => _createdAtEmployeeWallet;
  String? get flatID => _flatID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmployeeWalletID'] = _employeeWalletID;
    map['EmployeeID'] = _employeeID;
    map['TitleAR'] = _titleAR;
    map['TitleEn'] = _titleEn;
    map['TextAR'] = _textAR;
    map['TextEn'] = _textEn;
    map['Money'] = _money;
    map['Type'] = _type;
    map['lastUpdatedEmployeeWallet'] = _lastUpdatedEmployeeWallet;
    map['CreatedAtEmployeeWallet'] = _createdAtEmployeeWallet;
    map['FlatID'] = _flatID;
    return map;
  }

}