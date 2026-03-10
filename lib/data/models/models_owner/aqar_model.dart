/// status_code : 200
/// success : true
/// data : {"AqarID":"4","AqarName":"Aqar1","OwnerID":"5","FloarNum":"4","AreaID":"1","GoverID":"1","AqarPhoto":"","Status":"ACTIVE","lastUpdatedAqar":"2025-06-12 20:45:10","CreatedAtAqar":"2025-06-12 20:45:10","AqarLat":"31.23","AqarLongt":"30.32389"}
/// message : "Sing up sucssesfully"
library;

class AqarModel {
  AqarModel({
      num? statusCode, 
      bool? success, 
      AqarInfo? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  AqarModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? AqarInfo.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  AqarInfo? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  AqarInfo? get data => _data;
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

/// AqarID : "4"
/// AqarName : "Aqar1"
/// OwnerID : "5"
/// FloarNum : "4"
/// AreaID : "1"
/// GoverID : "1"
/// AqarPhoto : ""
/// Status : "ACTIVE"
/// lastUpdatedAqar : "2025-06-12 20:45:10"
/// CreatedAtAqar : "2025-06-12 20:45:10"
/// AqarLat : "31.23"
/// AqarLongt : "30.32389"

class AqarInfo {
  AqarInfo({
    String? shterakStop,
    String? bakatID,
    String? aqarID,
    String? aqarTypeNameAr,
    String? aqarTypeNameEn,
    String? aqarName,
    String? ownerID,
    String? realfloorsNum,
    String? floarNum,
    String? areaID,
    String? goverID,
    String? aqarPhoto,
    String? aqarTypeID,
    String? status,
    String? lastUpdatedAqar,
    String? createdAtAqar,
    String? aqarLat,
    String? aqarLongt,
    String? areaNameAR,
    String? areaNameEN,
    String? goverNameAR,
    String? goverNameEN,
    String? numType,
    String? timeFinishPay,
  }) {
    _numType = numType;
    _shterakStop = shterakStop;
    _aqarTypeNameAr = aqarTypeNameAr;
    _aqarTypeNameEn = aqarTypeNameEn;
    _aqarTypeID = aqarTypeID;
    _realfloorsNum = realfloorsNum;
    _aqarID = aqarID;
    _aqarName = aqarName;
    _ownerID = ownerID;
    _floarNum = floarNum;
    _areaID = areaID;
    _goverID = goverID;
    _aqarPhoto = aqarPhoto;
    _status = status;
    _lastUpdatedAqar = lastUpdatedAqar;
    _createdAtAqar = createdAtAqar;
    _aqarLat = aqarLat;
    _aqarLongt = aqarLongt;
    _areaNameAR = areaNameAR;
    _areaNameEN = areaNameEN;
    _goverNameAR = goverNameAR;
    _goverNameEN = goverNameEN;
    _timeFinishPay = timeFinishPay;
    _bakatID = bakatID;
  }

  AqarInfo.fromJson(dynamic json) {
    _shterakStop = json['EshterakStop'];
    _realfloorsNum = json['RealfloorsNum'];
    _aqarTypeNameEn = json['AqarTypeNameEn'];
    _aqarTypeNameAr = json['AqarTypeNameAr'];
    _aqarTypeID = json['AqarTypeID'];
    _aqarID = json['AqarID'];
    _aqarName = json['AqarName'];
    _ownerID = json['OwnerID'];
    _floarNum = json['FloarNum'];
    _areaID = json['AreaID'];
    _goverID = json['GoverID'];
    _aqarPhoto = json['AqarPhoto'];
    _status = json['Status'];
    _lastUpdatedAqar = json['lastUpdatedAqar'];
    _createdAtAqar = json['CreatedAtAqar'];
    _aqarLat = json['AqarLat'];
    _aqarLongt = json['AqarLongt'];
    _areaNameAR = json['AreaNameAR'];
    _areaNameEN = json['AreaNameEN'];
    _goverNameAR = json['GoverNameAR'];
    _goverNameEN = json['GoverNameEN'];
    _numType = json['NumType'];
    _price = json['Price'];
    _timeFinishPay = json['TimeFinishPay'];
    _bakatID = json['BakatID'];
  }
  String? _shterakStop;
  String? _bakatID;
  String? _timeFinishPay;
  String? _numType;
  String? _price;
  String? _aqarTypeNameAr;
  String? _aqarTypeNameEn;
  String? _aqarTypeID;
  String? _realfloorsNum;
  String? _aqarID;
  String? _aqarName;
  String? _ownerID;
  String? _floarNum;
  String? _areaID;
  String? _goverID;
  String? _aqarPhoto;
  String? _status;
  String? _lastUpdatedAqar;
  String? _createdAtAqar;
  String? _aqarLat;
  String? _aqarLongt;
  String? _areaNameAR;
  String? _areaNameEN;
  String? _goverNameAR;
  String? _goverNameEN;

  // Getters
  String? get shterakStop => _shterakStop;
  String? get timeFinishPay => _timeFinishPay;
  String? get price => _price;
  String? get numType => _numType;
  String? get aqarTypeNameAr => _aqarTypeNameAr;
  String? get aqarTypeNameEn => _aqarTypeNameEn;
  String? get aqarTypeID => _aqarTypeID;
  String? get realfloorsNum => _realfloorsNum;
  String? get aqarID => _aqarID;
  String? get aqarName => _aqarName;
  String? get ownerID => _ownerID;
  String? get floarNum => _floarNum;
  String? get areaID => _areaID;
  String? get goverID => _goverID;
  String? get aqarPhoto => _aqarPhoto;
  String? get status => _status;
  String? get lastUpdatedAqar => _lastUpdatedAqar;
  String? get createdAtAqar => _createdAtAqar;
  String? get aqarLat => _aqarLat;
  String? get aqarLongt => _aqarLongt;
  String? get areaNameAR => _areaNameAR;
  String? get areaNameEN => _areaNameEN;
  String? get goverNameAR => _goverNameAR;
  String? get goverNameEN => _goverNameEN;
  String? get bakatID => _bakatID;

  set shterakStop(String? value) => _shterakStop = value;
  set numType(String? value) => _numType = value;
  set price(String? value) => _price = value;
  set timeFinishPay(String? value) => _timeFinishPay = value;
  set bakatID(String? value) => _bakatID = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EshterakStop'] = _shterakStop;
    map['AqarTypeNameEn'] =_aqarTypeNameEn;
    map['AqarTypeNameAr'] = _aqarTypeNameAr;
    map['AqarTypeID'] = _aqarTypeID;
    map['BakatID'] = _bakatID;
    map['AqarID'] = _aqarID;
    map['AqarName'] = _aqarName;
    map['OwnerID'] = _ownerID;
    map['FloarNum'] = _floarNum;
    map['RealfloorsNum'] = _realfloorsNum;
    map['AreaID'] = _areaID;
    map['GoverID'] = _goverID;
    map['AqarPhoto'] = _aqarPhoto;
    map['Status'] = _status;
    map['lastUpdatedAqar'] = _lastUpdatedAqar;
    map['CreatedAtAqar'] = _createdAtAqar;
    map['AqarLat'] = _aqarLat;
    map['AqarLongt'] = _aqarLongt;
    map['AreaNameAR'] = _areaNameAR;
    map['AreaNameEN'] = _areaNameEN;
    map['GoverNameAR'] = _goverNameAR;
    map['GoverNameEN'] = _goverNameEN;
    map['NumType'] = _numType;
    map['Price'] = _price;
    map['TimeFinishPay'] = _timeFinishPay;
    map['BakatID'] = bakatID;
    return map;
  }
}
