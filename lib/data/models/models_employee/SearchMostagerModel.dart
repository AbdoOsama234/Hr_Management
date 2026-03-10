/// status_code : 200
/// success : true
/// data : [{"UName":"Ahmed Hassen","Phone":"201151521156","BetakaHaweya":"-"}]
/// message : "sucssesfully"
library;

class SearchMostagerModel {
  SearchMostagerModel({
      num? statusCode, 
      bool? success, 
      List<SearchMostagerInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  SearchMostagerModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchMostagerInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<SearchMostagerInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<SearchMostagerInfoModel>? get data => _data;
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

/// UName : "Ahmed Hassen"
/// Phone : "201151521156"
/// BetakaHaweya : "-"

class SearchMostagerInfoModel {
  SearchMostagerInfoModel({
      String? uName, 
      String? phone, 
      String? betakaHaweya,}){
    _uName = uName;
    _phone = phone;
    _betakaHaweya = betakaHaweya;
}

  SearchMostagerInfoModel.fromJson(dynamic json) {
    _uName = json['UName'];
    _phone = json['Phone'];
    _betakaHaweya = json['BetakaHaweya'];
  }
  String? _uName;
  String? _phone;
  String? _betakaHaweya;

  String? get uName => _uName;
  String? get phone => _phone;
  String? get betakaHaweya => _betakaHaweya;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UName'] = _uName;
    map['Phone'] = _phone;
    map['BetakaHaweya'] = _betakaHaweya;
    return map;
  }

}