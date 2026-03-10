/// status_code : 200
/// success : true
/// data : {"Arbah":"300","ArbahTextAr":"اخر ايام","ArbahTextEN":"Last Days","Motaker":"0","MotakerText":"دفعات متاخره","MotakerTextEN":"Overdue payments","Mostahak":"0","MostahakText":"مستحقه","MostahakTextEN":"Payable","Dakl":"300","Masroof":"0","Safi":"300","RENT":"6","ALL":"8","NotRent":"2","M1":"0","M2":"0","M3":"0","M4":"0","M5":"0","M6":"0","M7":"0","M8":"0","M9":"300","M10":"0","M11":"0","M12":"0","L1":"0","L2":"0","L3":"0","L4":"0","L5":"0","L6":"0","L7":"0","L8":"0","L9":"0","L10":"0","L11":"0","L12":"0"}
/// message : "sucssesfully"
library;

class GetHomeStatsModel {
  GetHomeStatsModel({
      num? statusCode, 
      bool? success, 
      GetHomeStatsInfoModel? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetHomeStatsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _data = json['data'] != null ? GetHomeStatsInfoModel.fromJson(json['data']) : null;
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  GetHomeStatsInfoModel? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  GetHomeStatsInfoModel? get data => _data;
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

/// Arbah : "300"
/// ArbahTextAr : "اخر ايام"
/// ArbahTextEN : "Last Days"
/// Motaker : "0"
/// MotakerText : "دفعات متاخره"
/// MotakerTextEN : "Overdue payments"
/// Mostahak : "0"
/// MostahakText : "مستحقه"
/// MostahakTextEN : "Payable"
/// Dakl : "300"
/// Masroof : "0"
/// Safi : "300"
/// RENT : "6"
/// ALL : "8"
/// NotRent : "2"
/// M1 : "0"
/// M2 : "0"
/// M3 : "0"
/// M4 : "0"
/// M5 : "0"
/// M6 : "0"
/// M7 : "0"
/// M8 : "0"
/// M9 : "300"
/// M10 : "0"
/// M11 : "0"
/// M12 : "0"
/// L1 : "0"
/// L2 : "0"
/// L3 : "0"
/// L4 : "0"
/// L5 : "0"
/// L6 : "0"
/// L7 : "0"
/// L8 : "0"
/// L9 : "0"
/// L10 : "0"
/// L11 : "0"
/// L12 : "0"

class GetHomeStatsInfoModel {
  GetHomeStatsInfoModel({
      String? arbah, 
      String? arbahTextAr, 
      String? arbahTextEN, 
      String? motaker, 
      String? motakerText, 
      String? motakerTextEN, 
      String? mostahak, 
      String? mostahakText, 
      String? mostahakTextEN, 
      String? dakl, 
      String? masroof, 
      String? safi, 
      String? rent, 
      String? all, 
      String? notRent, 
      String? m1, 
      String? m2, 
      String? m3, 
      String? m4, 
      String? m5, 
      String? m6, 
      String? m7, 
      String? m8, 
      String? m9, 
      String? m10, 
      String? m11, 
      String? m12, 
      String? l1, 
      String? l2, 
      String? l3, 
      String? l4, 
      String? l5, 
      String? l6, 
      String? l7, 
      String? l8, 
      String? l9, 
      String? l10, 
      String? l11, 
      String? l12,}){
    _arbah = arbah;
    _arbahTextAr = arbahTextAr;
    _arbahTextEN = arbahTextEN;
    _motaker = motaker;
    _motakerText = motakerText;
    _motakerTextEN = motakerTextEN;
    _mostahak = mostahak;
    _mostahakText = mostahakText;
    _mostahakTextEN = mostahakTextEN;
    _dakl = dakl;
    _masroof = masroof;
    _safi = safi;
    _rent = rent;
    _all = all;
    _notRent = notRent;
    _m1 = m1;
    _m2 = m2;
    _m3 = m3;
    _m4 = m4;
    _m5 = m5;
    _m6 = m6;
    _m7 = m7;
    _m8 = m8;
    _m9 = m9;
    _m10 = m10;
    _m11 = m11;
    _m12 = m12;
    _l1 = l1;
    _l2 = l2;
    _l3 = l3;
    _l4 = l4;
    _l5 = l5;
    _l6 = l6;
    _l7 = l7;
    _l8 = l8;
    _l9 = l9;
    _l10 = l10;
    _l11 = l11;
    _l12 = l12;
}

  GetHomeStatsInfoModel.fromJson(dynamic json) {
    _arbah = json['Arbah'];
    _arbahTextAr = json['ArbahTextAr'];
    _arbahTextEN = json['ArbahTextEN'];
    _motaker = json['Motaker'];
    _motakerText = json['MotakerText'];
    _motakerTextEN = json['MotakerTextEN'];
    _mostahak = json['Mostahak'];
    _mostahakText = json['MostahakText'];
    _mostahakTextEN = json['MostahakTextEN'];
    _dakl = json['Dakl'];
    _masroof = json['Masroof'];
    _safi = json['Safi'];
    _rent = json['RENT'];
    _all = json['ALL'];
    _notRent = json['NotRent'];
    _m1 = json['M1'];
    _m2 = json['M2'];
    _m3 = json['M3'];
    _m4 = json['M4'];
    _m5 = json['M5'];
    _m6 = json['M6'];
    _m7 = json['M7'];
    _m8 = json['M8'];
    _m9 = json['M9'];
    _m10 = json['M10'];
    _m11 = json['M11'];
    _m12 = json['M12'];
    _l1 = json['L1'];
    _l2 = json['L2'];
    _l3 = json['L3'];
    _l4 = json['L4'];
    _l5 = json['L5'];
    _l6 = json['L6'];
    _l7 = json['L7'];
    _l8 = json['L8'];
    _l9 = json['L9'];
    _l10 = json['L10'];
    _l11 = json['L11'];
    _l12 = json['L12'];
  }
  String? _arbah;
  String? _arbahTextAr;
  String? _arbahTextEN;
  String? _motaker;
  String? _motakerText;
  String? _motakerTextEN;
  String? _mostahak;
  String? _mostahakText;
  String? _mostahakTextEN;
  String? _dakl;
  String? _masroof;
  String? _safi;
  String? _rent;
  String? _all;
  String? _notRent;
  String? _m1;
  String? _m2;
  String? _m3;
  String? _m4;
  String? _m5;
  String? _m6;
  String? _m7;
  String? _m8;
  String? _m9;
  String? _m10;
  String? _m11;
  String? _m12;
  String? _l1;
  String? _l2;
  String? _l3;
  String? _l4;
  String? _l5;
  String? _l6;
  String? _l7;
  String? _l8;
  String? _l9;
  String? _l10;
  String? _l11;
  String? _l12;

  String? get arbah => _arbah;
  String? get arbahTextAr => _arbahTextAr;
  String? get arbahTextEN => _arbahTextEN;
  String? get motaker => _motaker;
  String? get motakerText => _motakerText;
  String? get motakerTextEN => _motakerTextEN;
  String? get mostahak => _mostahak;
  String? get mostahakText => _mostahakText;
  String? get mostahakTextEN => _mostahakTextEN;
  String? get dakl => _dakl;
  String? get masroof => _masroof;
  String? get safi => _safi;
  String? get rent => _rent;
  String? get all => _all;
  String? get notRent => _notRent;
  String? get m1 => _m1;
  String? get m2 => _m2;
  String? get m3 => _m3;
  String? get m4 => _m4;
  String? get m5 => _m5;
  String? get m6 => _m6;
  String? get m7 => _m7;
  String? get m8 => _m8;
  String? get m9 => _m9;
  String? get m10 => _m10;
  String? get m11 => _m11;
  String? get m12 => _m12;
  String? get l1 => _l1;
  String? get l2 => _l2;
  String? get l3 => _l3;
  String? get l4 => _l4;
  String? get l5 => _l5;
  String? get l6 => _l6;
  String? get l7 => _l7;
  String? get l8 => _l8;
  String? get l9 => _l9;
  String? get l10 => _l10;
  String? get l11 => _l11;
  String? get l12 => _l12;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Arbah'] = _arbah;
    map['ArbahTextAr'] = _arbahTextAr;
    map['ArbahTextEN'] = _arbahTextEN;
    map['Motaker'] = _motaker;
    map['MotakerText'] = _motakerText;
    map['MotakerTextEN'] = _motakerTextEN;
    map['Mostahak'] = _mostahak;
    map['MostahakText'] = _mostahakText;
    map['MostahakTextEN'] = _mostahakTextEN;
    map['Dakl'] = _dakl;
    map['Masroof'] = _masroof;
    map['Safi'] = _safi;
    map['RENT'] = _rent;
    map['ALL'] = _all;
    map['NotRent'] = _notRent;
    map['M1'] = _m1;
    map['M2'] = _m2;
    map['M3'] = _m3;
    map['M4'] = _m4;
    map['M5'] = _m5;
    map['M6'] = _m6;
    map['M7'] = _m7;
    map['M8'] = _m8;
    map['M9'] = _m9;
    map['M10'] = _m10;
    map['M11'] = _m11;
    map['M12'] = _m12;
    map['L1'] = _l1;
    map['L2'] = _l2;
    map['L3'] = _l3;
    map['L4'] = _l4;
    map['L5'] = _l5;
    map['L6'] = _l6;
    map['L7'] = _l7;
    map['L8'] = _l8;
    map['L9'] = _l9;
    map['L10'] = _l10;
    map['L11'] = _l11;
    map['L12'] = _l12;
    return map;
  }

}