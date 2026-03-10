/// status_code : 200
/// success : true
/// data : [{"BillingID":"1","AqarID":"4","OwnerID":"11","BillingPrice":"1000","lastUpdatedBilling":"2025-09-24 12:24:59","CreatedAtBilling":"2025-09-24 12:24:59","Textt":"for pay aqar"},{"BillingID":"2","AqarID":"4","OwnerID":"11","BillingPrice":"1000","lastUpdatedBilling":"2025-09-24 12:25:08","CreatedAtBilling":"2025-09-24 12:25:08","Textt":"for pay aqar"},{"BillingID":"3","AqarID":"4","OwnerID":"11","BillingPrice":"1000","lastUpdatedBilling":"2025-09-24 12:25:09","CreatedAtBilling":"2025-09-24 12:25:09","Textt":"for pay aqar"},{"BillingID":"4","AqarID":"4","OwnerID":"11","BillingPrice":"1000","lastUpdatedBilling":"2025-09-24 12:25:09","CreatedAtBilling":"2025-09-24 12:25:09","Textt":"for pay aqar"}]
/// message : "sucssesfully"
library;

class GetAllMyBillsModel {
  GetAllMyBillsModel({
      num? statusCode, 
      bool? success, 
      List<BillInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  GetAllMyBillsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BillInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<BillInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<BillInfoModel>? get data => _data;
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

/// BillingID : "1"
/// AqarID : "4"
/// OwnerID : "11"
/// BillingPrice : "1000"
/// lastUpdatedBilling : "2025-09-24 12:24:59"
/// CreatedAtBilling : "2025-09-24 12:24:59"
/// Textt : "for pay aqar"

class BillInfoModel {
  BillInfoModel({
      String? billingID, 
      String? aqarID, 
      String? ownerID, 
      String? billingPrice, 
      String? lastUpdatedBilling, 
      String? createdAtBilling, 
      String? textt,}){
    _billingID = billingID;
    _aqarID = aqarID;
    _ownerID = ownerID;
    _billingPrice = billingPrice;
    _lastUpdatedBilling = lastUpdatedBilling;
    _createdAtBilling = createdAtBilling;
    _textt = textt;
}

  BillInfoModel.fromJson(dynamic json) {
    _billingID = json['BillingID'];
    _aqarID = json['AqarID'];
    _ownerID = json['OwnerID'];
    _billingPrice = json['BillingPrice'];
    _lastUpdatedBilling = json['lastUpdatedBilling'];
    _createdAtBilling = json['CreatedAtBilling'];
    _textt = json['Textt'];
  }
  String? _billingID;
  String? _aqarID;
  String? _ownerID;
  String? _billingPrice;
  String? _lastUpdatedBilling;
  String? _createdAtBilling;
  String? _textt;

  String? get billingID => _billingID;
  String? get aqarID => _aqarID;
  String? get ownerID => _ownerID;
  String? get billingPrice => _billingPrice;
  String? get lastUpdatedBilling => _lastUpdatedBilling;
  String? get createdAtBilling => _createdAtBilling;
  String? get textt => _textt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BillingID'] = _billingID;
    map['AqarID'] = _aqarID;
    map['OwnerID'] = _ownerID;
    map['BillingPrice'] = _billingPrice;
    map['lastUpdatedBilling'] = _lastUpdatedBilling;
    map['CreatedAtBilling'] = _createdAtBilling;
    map['Textt'] = _textt;
    return map;
  }

}