/// status_code : 200
/// success : true
/// data : {"TermsAndID":"1","EmpEng":"dfhjfdhfjkdhgjkhdfjkh","EmpArab":"يبنمايبتنيباتن","OwnerEng":"jfkljfdkljdfklfdj","OwnerArab":"نبمتيبنمتيبنمبت"}
/// message : "sucssesfully"
library;

class TermsModel {
  TermsModel({
    num? statusCode,
    bool? success,
    TermsInfoModel? data,
    String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
  }

  TermsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? TermsInfoModel.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  TermsInfoModel? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  TermsInfoModel? get data => _data;
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

/// TermsAndID : "1"
/// EmpEng : "dfhjfdhfjkdhgjkhdfjkh"
/// EmpArab : "يبنمايبتنيباتن"
/// OwnerEng : "jfkljfdkljdfklfdj"
/// OwnerArab : "نبمتيبنمتيبنمبت"

class TermsInfoModel {
  TermsInfoModel({
    String? termsAndID,
    String? empEng,
    String? empArab,
    String? ownerEng,
    String? ownerArab,}){
    _termsAndID = termsAndID;
    _empEng = empEng;
    _empArab = empArab;
    _ownerEng = ownerEng;
    _ownerArab = ownerArab;
  }

  TermsInfoModel.fromJson(dynamic json) {
    _termsAndID = json['TermsAndID'];
    _empEng = json['EmpEng'];
    _empArab = json['EmpArab'];
    _ownerEng = json['OwnerEng'];
    _ownerArab = json['OwnerArab'];
  }
  String? _termsAndID;
  String? _empEng;
  String? _empArab;
  String? _ownerEng;
  String? _ownerArab;

  String? get termsAndID => _termsAndID;
  String? get empEng => _empEng;
  String? get empArab => _empArab;
  String? get ownerEng => _ownerEng;
  String? get ownerArab => _ownerArab;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TermsAndID'] = _termsAndID;
    map['EmpEng'] = _empEng;
    map['EmpArab'] = _empArab;
    map['OwnerEng'] = _ownerEng;
    map['OwnerArab'] = _ownerArab;
    return map;
  }

}