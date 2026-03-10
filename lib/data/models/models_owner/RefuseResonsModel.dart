/// status_code : 200
/// success : true
/// data : [{"ReasonsRefuseID":"1","OwnerID":"1","Reason":"We need some information","Files":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-155900.","lastUpdatedReasonsRefuse":"2025-07-22 08:43:31","CreatedAtReasonsRefuse":"2025-07-21 10:25:14"},{"ReasonsRefuseID":"2","OwnerID":"1","Reason":"We need some information2","Files":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-493232.jpeg","lastUpdatedReasonsRefuse":"2025-07-22 13:11:09","CreatedAtReasonsRefuse":"2025-07-21 10:25:23"}]
/// message : "sucssesfully"
library;

class RefuseResonsModel {
  RefuseResonsModel({
      num? statusCode, 
      bool? success, 
      List<RefuseResonsInfoModel>? data,
      String? message,}){
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
}

  RefuseResonsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RefuseResonsInfoModel.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  bool? _success;
  List<RefuseResonsInfoModel>? _data;
  String? _message;

  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<RefuseResonsInfoModel>? get data => _data;
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

/// ReasonsRefuseID : "1"
/// OwnerID : "1"
/// Reason : "We need some information"
/// Files : "https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-155900."
/// lastUpdatedReasonsRefuse : "2025-07-22 08:43:31"
/// CreatedAtReasonsRefuse : "2025-07-21 10:25:14"

class RefuseResonsInfoModel {
  RefuseResonsInfoModel({
      String? reasonsRefuseID, 
      String? ownerID, 
      String? reason, 
      String? files, 
      String? lastUpdatedReasonsRefuse, 
      String? createdAtReasonsRefuse,}){
    _reasonsRefuseID = reasonsRefuseID;
    _ownerID = ownerID;
    _reason = reason;
    _files = files;
    _lastUpdatedReasonsRefuse = lastUpdatedReasonsRefuse;
    _createdAtReasonsRefuse = createdAtReasonsRefuse;
}

  RefuseResonsInfoModel.fromJson(dynamic json) {
    _reasonsRefuseID = json['ReasonsRefuseID'];
    _ownerID = json['OwnerID'];
    _reason = json['Reason'];
    _files = json['Files'];
    _lastUpdatedReasonsRefuse = json['lastUpdatedReasonsRefuse'];
    _createdAtReasonsRefuse = json['CreatedAtReasonsRefuse'];
  }
  String? _reasonsRefuseID;
  String? _ownerID;
  String? _reason;
  String? _files;
  String? _lastUpdatedReasonsRefuse;
  String? _createdAtReasonsRefuse;

  String? get reasonsRefuseID => _reasonsRefuseID;
  String? get ownerID => _ownerID;
  String? get reason => _reason;
  String? get files => _files;
  String? get lastUpdatedReasonsRefuse => _lastUpdatedReasonsRefuse;
  String? get createdAtReasonsRefuse => _createdAtReasonsRefuse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ReasonsRefuseID'] = _reasonsRefuseID;
    map['OwnerID'] = _ownerID;
    map['Reason'] = _reason;
    map['Files'] = _files;
    map['lastUpdatedReasonsRefuse'] = _lastUpdatedReasonsRefuse;
    map['CreatedAtReasonsRefuse'] = _createdAtReasonsRefuse;
    return map;
  }

}