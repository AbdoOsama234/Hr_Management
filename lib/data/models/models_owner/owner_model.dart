import 'owner_info.dart';

/// status_code : 200
/// success : true
/// data : {"OwnerID":"1","OwnerKey":"+20","OwnerPhone":"1159050530","OwnerFName":"Abdo","OwnerLName":"Esam","OwnerEmail":"a@y.com","OwnerPhoto":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-301288.png","FirebaseToken":"djsklfjsdkfjlsdkljfkldsjfklsdjfklj","Token":"97e72f99e7190b75328b1bf86268383c1b2ed87bb0173047193ba4eda04bbdd05f669f1501b78f0698c6458d506c64e9ff8102c8642a27511e0adf1516596071","OwnerStatus":"PENDING","lastUpdatedOwner":"2025-06-08 16:12:35","CreatedAtOwner":"2025-06-08 16:12:35"}
/// message : "sucssesfully"

class OwnerModel {
  OwnerModel({
    num? statusCode,
    bool? success,
    QwnerModel? data,
    String? message,
  }) {
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
  }

  OwnerModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? QwnerModel.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  QwnerModel? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  QwnerModel? get data => _data;
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

/// OwnerID : "1"
/// OwnerKey : "+20"
/// OwnerPhone : "1159050530"
/// OwnerFName : "Abdo"
/// OwnerLName : "Esam"
/// OwnerEmail : "a@y.com"
/// OwnerPhoto : "https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-301288.png"
/// FirebaseToken : "djsklfjsdkfjlsdkljfkldsjfklsdjfklj"
/// Token : "97e72f99e7190b75328b1bf86268383c1b2ed87bb0173047193ba4eda04bbdd05f669f1501b78f0698c6458d506c64e9ff8102c8642a27511e0adf1516596071"
/// OwnerStatus : "PENDING"
/// lastUpdatedOwner : "2025-06-08 16:12:35"
/// CreatedAtOwner : "2025-06-08 16:12:35"

// class OwnerInfo {
//   OwnerInfo({
//       String? ownerID,
//       String? ownerKey,
//       String? ownerPhone,
//       String? ownerFName,
//       String? ownerLName,
//       String? ownerEmail,
//       String? ownerPhoto,
//       String? firebaseToken,
//       String? token,
//       String? ownerStatus,
//       String? lastUpdatedOwner,
//       String? createdAtOwner,}){
//     _ownerID = ownerID;
//     _ownerKey = ownerKey;
//     _ownerPhone = ownerPhone;
//     _ownerFName = ownerFName;
//     _ownerLName = ownerLName;
//     _ownerEmail = ownerEmail;
//     _ownerPhoto = ownerPhoto;
//     _firebaseToken = firebaseToken;
//     _token = token;
//     _ownerStatus = ownerStatus;
//     _lastUpdatedOwner = lastUpdatedOwner;
//     _createdAtOwner = createdAtOwner;
// }
//
//   OwnerInfo.fromJson(dynamic json) {
//     _ownerID = json['OwnerID'];
//     _ownerKey = json['OwnerKey'];
//     _ownerPhone = json['OwnerPhone'];
//     _ownerFName = json['OwnerFName'];
//     _ownerLName = json['OwnerLName'];
//     _ownerEmail = json['OwnerEmail'];
//     _ownerPhoto = json['OwnerPhoto'];
//     _firebaseToken = json['FirebaseToken'];
//     _token = json['Token'];
//     _ownerStatus = json['OwnerStatus'];
//     _lastUpdatedOwner = json['lastUpdatedOwner'];
//     _createdAtOwner = json['CreatedAtOwner'];
//   }
//   String? _ownerID;
//   String? _ownerKey;
//   String? _ownerPhone;
//   String? _ownerFName;
//   String? _ownerLName;
//   String? _ownerEmail;
//   String? _ownerPhoto;
//   String? _firebaseToken;
//   String? _token;
//   String? _ownerStatus;
//   String? _lastUpdatedOwner;
//   String? _createdAtOwner;
//
//   String? get ownerID => _ownerID;
//   String? get ownerKey => _ownerKey;
//   String? get ownerPhone => _ownerPhone;
//   String? get ownerFName => _ownerFName;
//   String? get ownerLName => _ownerLName;
//   String? get ownerEmail => _ownerEmail;
//   String? get ownerPhoto => _ownerPhoto;
//   String? get firebaseToken => _firebaseToken;
//   String? get token => _token;
//   String? get ownerStatus => _ownerStatus;
//   String? get lastUpdatedOwner => _lastUpdatedOwner;
//   String? get createdAtOwner => _createdAtOwner;
//
//   set ownerPhoto(String? value) => _ownerPhoto = value;
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['OwnerID'] = _ownerID;
//     map['OwnerKey'] = _ownerKey;
//     map['OwnerPhone'] = _ownerPhone;
//     map['OwnerFName'] = _ownerFName;
//     map['OwnerLName'] = _ownerLName;
//     map['OwnerEmail'] = _ownerEmail;
//     map['OwnerPhoto'] = _ownerPhoto;
//     map['FirebaseToken'] = _firebaseToken;
//     map['Token'] = _token;
//     map['OwnerStatus'] = _ownerStatus;
//     map['lastUpdatedOwner'] = _lastUpdatedOwner;
//     map['CreatedAtOwner'] = _createdAtOwner;
//     return map;
//   }
//   bool get isEmpty {
//     return (_ownerID == null || _ownerID!.isEmpty) &&
//         (_ownerPhone == null || _ownerPhone!.isEmpty) &&
//         (_ownerEmail == null || _ownerEmail!.isEmpty);
//   }
//
// }