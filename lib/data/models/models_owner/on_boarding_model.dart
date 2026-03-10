/// status_code : 200
/// success : true
/// data : [{"IntroID":"1","Image":"https://engaztechnology.net/aqaratyAPI/Owner/PHOTO/happy1.png","TitleEN":"Title1","TitleAR":"عنوان 1","DescEN":"Desc1","DescAR":"وصف 2","IntroStatus":"ACTIVE","Tarteb":"0"},{"IntroID":"2","Image":"https://engaztechnology.net/aqaratyAPI/Owner/PHOTO/window1.png","TitleEN":"Title2","TitleAR":"عنوان 2","DescEN":"Desc2","DescAR":"وصف 3","IntroStatus":"ACTIVE","Tarteb":"0"},{"IntroID":"3","Image":"https://engaztechnology.net/aqaratyAPI/Owner/PHOTO/home-control1.png","TitleEN":"Title222","TitleAR":"عنوان 22","DescEN":"Desc22","DescAR":"وصف 23","IntroStatus":"ACTIVE","Tarteb":"0"}]
/// message : "sucssesfully"
library;

class OnBoardingModel {
  OnBoardingModel({
      num? statusCode, 
      bool? success, 
      List<OnBoardingInfo>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  OnBoardingModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OnBoardingInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<OnBoardingInfo>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<OnBoardingInfo>? get data => _data;
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

/// IntroID : "1"
/// Image : "https://engaztechnology.net/aqaratyAPI/Owner/PHOTO/happy1.png"
/// TitleEN : "Title1"
/// TitleAR : "عنوان 1"
/// DescEN : "Desc1"
/// DescAR : "وصف 2"
/// IntroStatus : "ACTIVE"
/// Tarteb : "0"

class OnBoardingInfo {
  OnBoardingInfo({
      String? introID, 
      String? image, 
      String? titleEN, 
      String? titleAR, 
      String? descEN, 
      String? descAR, 
      String? introStatus, 
      String? tarteb,}){
    _introID = introID;
    _image = image;
    _titleEN = titleEN;
    _titleAR = titleAR;
    _descEN = descEN;
    _descAR = descAR;
    _introStatus = introStatus;
    _tarteb = tarteb;
}

  OnBoardingInfo.fromJson(dynamic json) {
    _introID = json['IntroID'];
    _image = json['Image'];
    _titleEN = json['TitleEN'];
    _titleAR = json['TitleAR'];
    _descEN = json['DescEN'];
    _descAR = json['DescAR'];
    _introStatus = json['IntroStatus'];
    _tarteb = json['Tarteb'];
  }
  String? _introID;
  String? _image;
  String? _titleEN;
  String? _titleAR;
  String? _descEN;
  String? _descAR;
  String? _introStatus;
  String? _tarteb;

  String? get introID => _introID;
  String? get image => _image;
  String? get titleEN => _titleEN;
  String? get titleAR => _titleAR;
  String? get descEN => _descEN;
  String? get descAR => _descAR;
  String? get introStatus => _introStatus;
  String? get tarteb => _tarteb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntroID'] = _introID;
    map['Image'] = _image;
    map['TitleEN'] = _titleEN;
    map['TitleAR'] = _titleAR;
    map['DescEN'] = _descEN;
    map['DescAR'] = _descAR;
    map['IntroStatus'] = _introStatus;
    map['Tarteb'] = _tarteb;
    return map;
  }

}