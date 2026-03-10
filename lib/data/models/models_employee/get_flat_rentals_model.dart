/// status_code : 200
/// success : true
/// data : [{"FlatAndRentalID":"1","EmployeeID":"1","FlatID":"1","Phone":"+201159050530","UName":"Abdelrahman","lastUpdatedFlatAndRental":"2025-06-22 15:19:42","CreatedAtFlatAndRental":"2025-06-22 15:04:20","RentType":"1","Price":"1000","StartTime":"2024-12-11","LastTime":"2025-1-11","RentStatus":"PAST","FlatTypesArab":"مكتب","FlatTypesEng":"Office"},{"FlatAndRentalID":"2","EmployeeID":"1","FlatID":"1","Phone":"+201116310853","UName":"Hassan","lastUpdatedFlatAndRental":"2025-06-22 15:20:32","CreatedAtFlatAndRental":"2025-06-22 15:04:34","RentType":"2","Price":"2000","StartTime":"2025-1-11","LastTime":"CURRENT","RentStatus":"ACTIVE","FlatTypesArab":"شقة","FlatTypesEng":"Flat"}]
/// message : "sucssesfully"
library;

class GetFlatRentalsModel {
  GetFlatRentalsModel({
      num? statusCode, 
      bool? success, 
      List<FlatRentalInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetFlatRentalsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FlatRentalInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<FlatRentalInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<FlatRentalInfoModel>? get data => _data;
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

/// FlatAndRentalID : "1"
/// EmployeeID : "1"
/// FlatID : "1"
/// Phone : "+201159050530"
/// UName : "Abdelrahman"
/// lastUpdatedFlatAndRental : "2025-06-22 15:19:42"
/// CreatedAtFlatAndRental : "2025-06-22 15:04:20"
/// RentType : "1"
/// Price : "1000"
/// StartTime : "2024-12-11"
/// LastTime : "2025-1-11"
/// RentStatus : "PAST"
/// FlatTypesArab : "مكتب"
/// FlatTypesEng : "Office"

class FlatRentalInfoModel {
  FlatRentalInfoModel({
    String? moneyPlusOrrMin,
      String? flatAndRentalID,
    String? totalPaid,
      String? employeeID, 
      String? flatID,
      String? phone, 
      String? uName,
    String? betakaHaweya,
      String? lastUpdatedFlatAndRental, 
      String? createdAtFlatAndRental, 
      String? rentType, 
      String? price, 
      String? startTime, 
      String? lastTime, 
      String? rentStatus, 
      String? flatTypesArab, 
      String? flatTypesEng,}){
_totalPaid = totalPaid;
    _flatAndRentalID = flatAndRentalID;
    _employeeID = employeeID;
    _flatID = flatID;
    _phone = phone;
    _uName = uName;
    _lastUpdatedFlatAndRental = lastUpdatedFlatAndRental;
    _createdAtFlatAndRental = createdAtFlatAndRental;
    _rentType = rentType;
    _price = price;
    _startTime = startTime;
    _lastTime = lastTime;
    _rentStatus = rentStatus;
    _flatTypesArab = flatTypesArab;
    _flatTypesEng = flatTypesEng;
    _moneyPlusOrrMin = moneyPlusOrrMin;
}

  FlatRentalInfoModel.fromJson(dynamic json) {
    _totalPaid = json['TotalPaid'];
    _moneyPlusOrrMin = json['MoneyPlusOrrMin'];
    _betakaHaweya = json['BetakaHaweya'];
    _flatAndRentalID = json['FlatAndRentalID'];
    _employeeID = json['EmployeeID'];
    _flatID = json['FlatID'];
    _phone = json['Phone'];
    _uName = json['UName'];
    _lastUpdatedFlatAndRental = json['lastUpdatedFlatAndRental'];
    _createdAtFlatAndRental = json['CreatedAtFlatAndRental'];
    _rentType = json['RentType'];
    _price = json['Price'];
    _startTime = json['StartTime'];
    _lastTime = json['LastTime'];
    _rentStatus = json['RentStatus'];
    _flatTypesArab = json['FlatTypesArab'];
    _flatTypesEng = json['FlatTypesEng'];
  }
  String? _totalPaid;
  String? _moneyPlusOrrMin;
  String? _betakaHaweya;
  String? _flatAndRentalID;
  String? _employeeID;
  String? _flatID;
  String? _phone;
  String? _uName;
  String? _lastUpdatedFlatAndRental;
  String? _createdAtFlatAndRental;
  String? _rentType;
  String? _price;
  String? _startTime;
  String? _lastTime;
  String? _rentStatus;
  String? _flatTypesArab;
  String? _flatTypesEng;

  String? get totalPaid => _totalPaid;
  String? get moneyPlusOrrMin => _moneyPlusOrrMin;
  String? get betakaHaweya => _betakaHaweya;
  String? get flatAndRentalID => _flatAndRentalID;
  String? get employeeID => _employeeID;
  String? get flatID => _flatID;
  String? get phone => _phone;
  String? get uName => _uName;
  String? get lastUpdatedFlatAndRental => _lastUpdatedFlatAndRental;
  String? get createdAtFlatAndRental => _createdAtFlatAndRental;
  String? get rentType => _rentType;
  String? get price => _price;
  String? get startTime => _startTime;
  String? get lastTime => _lastTime;
  String? get rentStatus => _rentStatus;
  String? get flatTypesArab => _flatTypesArab;
  String? get flatTypesEng => _flatTypesEng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalPaid'] = _totalPaid;
    map['MoneyPlusOrrMin'] = _moneyPlusOrrMin;
    map['FlatAndRentalID'] = _flatAndRentalID;
    map['EmployeeID'] = _employeeID;
    map['FlatID'] = _flatID;
    map['Phone'] = _phone;
    map['UName'] = _uName;
    map['lastUpdatedFlatAndRental'] = _lastUpdatedFlatAndRental;
    map['CreatedAtFlatAndRental'] = _createdAtFlatAndRental;
    map['RentType'] = _rentType;
    map['Price'] = _price;
    map['StartTime'] = _startTime;
    map['LastTime'] = _lastTime;
    map['RentStatus'] = _rentStatus;
    map['FlatTypesArab'] = _flatTypesArab;
    map['FlatTypesEng'] = _flatTypesEng;
    map['BetakaHaweya'] = _betakaHaweya;
    return map;
  }

}