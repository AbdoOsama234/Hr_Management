

import 'aqar_model.dart';

/// status_code : 200
/// success : true
/// data : [{"AqarID":"1","AqarName":"Aqar1","OwnerID":"1","FloarNum":"4","AreaID":"1","GoverID":"1","AqarPhoto":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-140463.png","Status":"ACTIVE","lastUpdatedAqar":"2025-06-08 18:44:58","CreatedAtAqar":"2025-06-08 18:27:49","AqarLat":"32/2323","AqarLongt":"31.43"},{"AqarID":"2","AqarName":"Aqar22","OwnerID":"1","FloarNum":"4","AreaID":"1","GoverID":"1","AqarPhoto":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-146443.png","Status":"ACTIVE","lastUpdatedAqar":"2025-06-14 14:26:49","CreatedAtAqar":"2025-06-08 18:45:03","AqarLat":"31.23","AqarLongt":"30.32389"},{"AqarID":"3","AqarName":"Aqar1","OwnerID":"1","FloarNum":"4","AreaID":"1","GoverID":"1","AqarPhoto":"","Status":"ACTIVE","lastUpdatedAqar":"2025-06-12 06:39:10","CreatedAtAqar":"2025-06-12 06:39:10","AqarLat":"31.23","AqarLongt":"30.32389"}]
/// message : "sucssesfully"

class MyAqarsModel {
  MyAqarsModel({
      num? statusCode, 
      bool? success, 
      List<AqarInfo>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  MyAqarsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AqarInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<AqarInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AqarInfo>? get data => _data;
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

/// AqarID : "1"
/// AqarName : "Aqar1"
/// OwnerID : "1"
/// FloarNum : "4"
/// AreaID : "1"
/// GoverID : "1"
/// AqarPhoto : "https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-140463.png"
/// Status : "ACTIVE"
/// lastUpdatedAqar : "2025-06-08 18:44:58"
/// CreatedAtAqar : "2025-06-08 18:27:49"
/// AqarLat : "32/2323"
/// AqarLongt : "31.43"

// class AqarInfo {
//   AqarInfo({
//       String? aqarID,
//       String? aqarName,
//       String? ownerID,
//       String? floarNum,
//       String? areaID,
//       String? goverID,
//       String? aqarPhoto,
//       String? status,
//       String? lastUpdatedAqar,
//       String? createdAtAqar,
//       String? aqarLat,
//       String? aqarLongt,}){
//     _aqarID = aqarID;
//     _aqarName = aqarName;
//     _ownerID = ownerID;
//     _floarNum = floarNum;
//     _areaID = areaID;
//     _goverID = goverID;
//     _aqarPhoto = aqarPhoto;
//     _status = status;
//     _lastUpdatedAqar = lastUpdatedAqar;
//     _createdAtAqar = createdAtAqar;
//     _aqarLat = aqarLat;
//     _aqarLongt = aqarLongt;
// }
//
//   AqarInfo.fromJson(dynamic json) {
//     _aqarID = json['AqarID'];
//     _aqarName = json['AqarName'];
//     _ownerID = json['OwnerID'];
//     _floarNum = json['FloarNum'];
//     _areaID = json['AreaID'];
//     _goverID = json['GoverID'];
//     _aqarPhoto = json['AqarPhoto'];
//     _status = json['Status'];
//     _lastUpdatedAqar = json['lastUpdatedAqar'];
//     _createdAtAqar = json['CreatedAtAqar'];
//     _aqarLat = json['AqarLat'];
//     _aqarLongt = json['AqarLongt'];
//   }
//   String? _aqarID;
//   String? _aqarName;
//   String? _ownerID;
//   String? _floarNum;
//   String? _areaID;
//   String? _goverID;
//   String? _aqarPhoto;
//   String? _status;
//   String? _lastUpdatedAqar;
//   String? _createdAtAqar;
//   String? _aqarLat;
//   String? _aqarLongt;
//
//   String? get aqarID => _aqarID;
//   String? get aqarName => _aqarName;
//   String? get ownerID => _ownerID;
//   String? get floarNum => _floarNum;
//   String? get areaID => _areaID;
//   String? get goverID => _goverID;
//   String? get aqarPhoto => _aqarPhoto;
//   String? get status => _status;
//   String? get lastUpdatedAqar => _lastUpdatedAqar;
//   String? get createdAtAqar => _createdAtAqar;
//   String? get aqarLat => _aqarLat;
//   String? get aqarLongt => _aqarLongt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['AqarID'] = _aqarID;
//     map['AqarName'] = _aqarName;
//     map['OwnerID'] = _ownerID;
//     map['FloarNum'] = _floarNum;
//     map['AreaID'] = _areaID;
//     map['GoverID'] = _goverID;
//     map['AqarPhoto'] = _aqarPhoto;
//     map['Status'] = _status;
//     map['lastUpdatedAqar'] = _lastUpdatedAqar;
//     map['CreatedAtAqar'] = _createdAtAqar;
//     map['AqarLat'] = _aqarLat;
//     map['AqarLongt'] = _aqarLongt;
//     return map;
//   }

//}