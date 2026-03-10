/// status_code : 200
/// success : true
/// data : [{"BakatID":"1","BakaTitle":"شهري","BakaTitleEn":"Monthly","BakaDescr":"الباقة شهريه تعمل معك شهر فقط من بدئ العمل بها","BakaDescrEN":"Just one month working","Timme":"30","Status":"ACTIVE","Price":0,"Dareba":10,"Service":20,"Total":30},{"BakatID":"2","BakaTitle":"سنوية","BakaTitleEn":"Year","BakaDescr":"تعمل الباقه سنويه ","BakaDescrEN":"just one year","Timme":"365","Status":"ACTIVE","Price":0,"Dareba":10,"Service":20,"Total":30}]
/// message : "sucssesfully"
library;

class GetAqarBakatModel {
  GetAqarBakatModel({
      num? statusCode, 
      bool? success, 
      List<AqarBakaInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetAqarBakatModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AqarBakaInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<AqarBakaInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AqarBakaInfoModel>? get data => _data;
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

/// BakatID : "1"
/// BakaTitle : "شهري"
/// BakaTitleEn : "Monthly"
/// BakaDescr : "الباقة شهريه تعمل معك شهر فقط من بدئ العمل بها"
/// BakaDescrEN : "Just one month working"
/// Timme : "30"
/// Status : "ACTIVE"
/// Price : 0
/// Dareba : 10
/// Service : 20
/// Total : 30

class AqarBakaInfoModel {
  AqarBakaInfoModel({
      String? bakatID, 
      String? bakaTitle, 
      String? bakaTitleEn, 
      String? bakaDescr, 
      String? bakaDescrEN, 
      String? timme, 
      String? status, 
      num? price, 
      num? dareba, 
      num? service, 
      num? total,
  }){
    _bakatID = bakatID;
    _bakaTitle = bakaTitle;
    _bakaTitleEn = bakaTitleEn;
    _bakaDescr = bakaDescr;
    _bakaDescrEN = bakaDescrEN;
    _timme = timme;
    _status = status;
    _price = price;
    _dareba = dareba;
    _service = service;
    _total = total;
}

  AqarBakaInfoModel.fromJson(dynamic json) {
    _bakatID = json['BakatID'];
    _bakaTitle = json['BakaTitle'];
    _bakaTitleEn = json['BakaTitleEn'];
    _bakaDescr = json['BakaDescr'];
    _bakaDescrEN = json['BakaDescrEN'];
    _timme = json['Timme'];
    _status = json['Status'];
    _price = json['Price'];
    _dareba = json['Dareba'];
    _service = json['Service'];
    _total = json['Total'];
  }
  String? _bakatID;
  String? _bakaTitle;
  String? _bakaTitleEn;
  String? _bakaDescr;
  String? _bakaDescrEN;
  String? _timme;
  String? _status;
  num? _price;
  num? _dareba;
  num? _service;
  num? _total;

  String? get bakatID => _bakatID;
  String? get bakaTitle => _bakaTitle;
  String? get bakaTitleEn => _bakaTitleEn;
  String? get bakaDescr => _bakaDescr;
  String? get bakaDescrEN => _bakaDescrEN;
  String? get timme => _timme;
  String? get status => _status;
  num? get price => _price;
  num? get dareba => _dareba;
  num? get service => _service;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BakatID'] = _bakatID;
    map['BakaTitle'] = _bakaTitle;
    map['BakaTitleEn'] = _bakaTitleEn;
    map['BakaDescr'] = _bakaDescr;
    map['BakaDescrEN'] = _bakaDescrEN;
    map['Timme'] = _timme;
    map['Status'] = _status;
    map['Price'] = _price;
    map['Dareba'] = _dareba;
    map['Service'] = _service;
    map['Total'] = _total;
    return map;
  }

}