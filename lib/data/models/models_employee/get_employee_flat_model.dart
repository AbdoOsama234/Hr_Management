// /// status_code : 200
// /// success : true
// /// data : [{"FlatID":"59","AqarID":"75","FlatNum":"3","FlatTypesID":"2","FlatPhoto":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-591542.png","FlatStatus":"ACTIVE","RentStatus":"NO","RentPrice":"32","lastUpdatedFlat":"2025-06-25 11:24:59","CreatedAtFlat":"2025-06-25 11:24:59","FlatSpecs":[{"FlatWithSpecID":"204","FlatID":"59","FlatTypesSpecificationID":"2","Value":"12","FlatTypesSpecificationArab":"مساحة","FlatTypesSpecificationEng":"Distance","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"2"},{"FlatWithSpecID":"205","FlatID":"59","FlatTypesSpecificationID":"5","Value":"er","FlatTypesSpecificationArab":"عدد الحجرات","FlatTypesSpecificationEng":"Number of rooms","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"2"}]}]
// /// message : "sucssesfully"
//
// class GetEmployeeFlatModel {
//   GetEmployeeFlatModel({
//       num? statusCode,
//       bool? success,
//       List<FlatInfoDetailsModel>? data,
//       String? message,}){
//     _statusCode = statusCode;
//     _success = success;
//     _data = data;
//     _message = message;
// }
//
//   GetEmployeeFlatModel.fromJson(dynamic json) {
//     _statusCode = json['status_code'];
//     _success = json['success'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(FlatInfoDetailsModel.fromJson(v));
//       });
//     }
//     _message = json['message'];
//   }
//   num? _statusCode;
//   bool? _success;
//   List<FlatInfoDetailsModel>? _data;
//   String? _message;
//
//   num? get statusCode => _statusCode;
//   bool? get success => _success;
//   List<FlatInfoDetailsModel>? get data => _data;
//   String? get message => _message;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status_code'] = _statusCode;
//     map['success'] = _success;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     map['message'] = _message;
//     return map;
//   }
//
// }
//
// /// FlatID : "59"
// /// AqarID : "75"
// /// FlatNum : "3"
// /// FlatTypesID : "2"
// /// FlatPhoto : "https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-591542.png"
// /// FlatStatus : "ACTIVE"
// /// RentStatus : "NO"
// /// RentPrice : "32"
// /// lastUpdatedFlat : "2025-06-25 11:24:59"
// /// CreatedAtFlat : "2025-06-25 11:24:59"
// /// FlatSpecs : [{"FlatWithSpecID":"204","FlatID":"59","FlatTypesSpecificationID":"2","Value":"12","FlatTypesSpecificationArab":"مساحة","FlatTypesSpecificationEng":"Distance","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"2"},{"FlatWithSpecID":"205","FlatID":"59","FlatTypesSpecificationID":"5","Value":"er","FlatTypesSpecificationArab":"عدد الحجرات","FlatTypesSpecificationEng":"Number of rooms","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"2"}]
//
// class FlatInfoDetailsModel {
//   FlatInfoDetailsModel({
//     String? aqarName,
//       String? flatID,
//     String? realfloorsNum,
//       String? aqarID,
//     String? rentType,
//     String? samahDate,
//       String? flatNum,
//       String? flatTypesID,
//       String? flatPhoto,
//     String? collectRenrDate,
//       String? flatStatus,
//       String? rentStatus,
//       String? rentPrice,
//       String? lastUpdatedFlat,
//       String? createdAtFlat,
//     String? rentTypeEng,
//     String? rentTypeArab,
//       List<FlatSpecs>? flatSpecs,}){
//     _aqarName = aqarName;
//     _flatID = flatID;
//     _aqarID = aqarID;
//     _realfloorsNum = realfloorsNum;
//     _flatNum = flatNum;
//     _rentType = rentType;
//     _flatTypesID = flatTypesID;
//     _flatPhoto = flatPhoto;
//     _flatStatus = flatStatus;
//     _rentStatus = rentStatus;
//     _rentPrice = rentPrice;
//     _collectRenrDate = collectRenrDate;
//     _lastUpdatedFlat = lastUpdatedFlat;
//     _createdAtFlat = createdAtFlat;
//     _flatSpecs = flatSpecs;
//     _rentTypeEng = rentTypeEng;
//     _rentTypeArab = rentTypeArab;
//     _samahDate = samahDate;
// }
//
//   FlatInfoDetailsModel.fromJson(dynamic json) {
//     _aqarName = json['AqarName'];
//     _realfloorsNum = json['RealfloorsNum'];
//     _samahDate = json['SamahDate'];
//     _flatID = json['FlatID'];
//     _rentType = json['RentType'];
//     _aqarID = json['AqarID'];
//     _flatNum = json['FlatNum'];
//     _flatTypesID = json['FlatTypesID'];
//     _flatPhoto = json['FlatPhoto'];
//     _flatStatus = json['FlatStatus'];
//     _rentStatus = json['RentStatus'];
//     _collectRenrDate = json['CollectRenrDate'];
//     _rentPrice = json['RentPrice'];
//     _lastUpdatedFlat = json['lastUpdatedFlat'];
//     _createdAtFlat = json['CreatedAtFlat'];
//     _rentTypeArab = json['RentTypeArab'];
//     _rentTypeEng = json['RentTypeEng'];
//     if (json['FlatSpecs'] != null) {
//       _flatSpecs = [];
//       json['FlatSpecs'].forEach((v) {
//         _flatSpecs?.add(FlatSpecs.fromJson(v));
//       });
//     }
//   }
//   String? _aqarName;
//   String? _realfloorsNum;
//   String? _samahDate;
//   String? _rentTypeEng;
//   String? _rentTypeArab;
//   String? _collectRenrDate;
//   String? _rentType;
//   String? _flatID;
//   String? _aqarID;
//   String? _flatNum;
//   String? _flatTypesID;
//   String? _flatPhoto;
//   String? _flatStatus;
//   String? _rentStatus;
//   String? _rentPrice;
//   String? _lastUpdatedFlat;
//   String? _createdAtFlat;
//   List<FlatSpecs>? _flatSpecs;
//   String? get aqarName => _aqarName;
//   String? get realfloorsNum => _realfloorsNum;
//   String? get samahDate => _samahDate;
//   String? get collectRenrDate => _collectRenrDate;
//   String? get rentType => _rentType;
//   String? get flatID => _flatID;
//   String? get aqarID => _aqarID;
//   String? get rentTypeEng => _rentTypeEng;
//   String? get rentTypeArab => _rentTypeArab;
//   String? get flatNum => _flatNum;
//   String? get flatTypesID => _flatTypesID;
//   String? get flatPhoto => _flatPhoto;
//   String? get flatStatus => _flatStatus;
//   String? get rentStatus => _rentStatus;
//   String? get rentPrice => _rentPrice;
//   String? get lastUpdatedFlat => _lastUpdatedFlat;
//   String? get createdAtFlat => _createdAtFlat;
//   List<FlatSpecs>? get flatSpecs => _flatSpecs;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['AqarName'] = _aqarName;
//     map['FlatID'] = _flatID;
//     map['SamahDate'] = _samahDate;
//     map['RentTypeArab'] = _rentTypeArab;
//     map['RealfloorsNum'] = _realfloorsNum;
//     map['RentTypeEng'] = _rentTypeEng;
//     map['AqarID'] = _aqarID;
//     map['FlatNum'] = _flatNum;
//     map['FlatTypesID'] = _flatTypesID;
//     map['FlatPhoto'] = _flatPhoto;
//     map['FlatStatus'] = _flatStatus;
//     map['RentStatus'] = _rentStatus;
//     map['rentType'] = _rentType;
//     map['RentPrice'] = _rentPrice;
//     map['lastUpdatedFlat'] = _lastUpdatedFlat;
//     map['CreatedAtFlat'] = _createdAtFlat;
//     if (_flatSpecs != null) {
//       map['FlatSpecs'] = _flatSpecs?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// FlatWithSpecID : "204"
// /// FlatID : "59"
// /// FlatTypesSpecificationID : "2"
// /// Value : "12"
// /// FlatTypesSpecificationArab : "مساحة"
// /// FlatTypesSpecificationEng : "Distance"
// /// FlatTypesSpecificationStatus : "ACTIVE"
// /// FlatTypesID : "2"
//

class GetEmployeeFlatModel {
  final int statusCode;
  final bool success;
  final List<FlatInfoDetailsModel> data;
  final String message;

  GetEmployeeFlatModel({
    required this.statusCode,
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetEmployeeFlatModel.fromJson(Map<String, dynamic> json) {
    return GetEmployeeFlatModel(
      statusCode: json['status_code'] ?? 0,
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FlatInfoDetailsModel.fromJson(e))
          .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}

class FlatInfoDetailsModel {
  final String? flatID;
  final String? aqarID;
  final String? flatNum;
  final String? flatTypesID;
  final String? flatPhoto;
  final String? flatStatus;
  final String? rentStatus;
  final String? rentPrice;
  final String? rentType;
  final String? lastUpdatedFlat;
  final String? createdAtFlat;
  final String? collectRentDate;
  final String? realFloorsNum;
  final String? samahDate;
  final String? rentTypeArab;
  final String? rentTypeEng;
  final AqarInfoModel? aqar;
  final List<FlatSpecs>? flatSpecs;

  FlatInfoDetailsModel({
    this.flatID,
    this.aqarID,
    this.flatNum,
    this.flatTypesID,
    this.flatPhoto,
    this.flatStatus,
    this.rentStatus,
    this.rentPrice,
    this.rentType,
    this.lastUpdatedFlat,
    this.createdAtFlat,
    this.collectRentDate,
    this.realFloorsNum,
    this.samahDate,
    this.rentTypeArab,
    this.rentTypeEng,
    this.aqar,
    this.flatSpecs,
  });

  factory FlatInfoDetailsModel.fromJson(Map<String, dynamic> json) {
    return FlatInfoDetailsModel(
      flatID: json['FlatID'],
      aqarID: json['AqarID'],
      flatNum: json['FlatNum'],
      flatTypesID: json['FlatTypesID'],
      flatPhoto: json['FlatPhoto'],
      flatStatus: json['FlatStatus'],
      rentStatus: json['RentStatus'],
      rentPrice: json['RentPrice'],
      rentType: json['RentType'],
      lastUpdatedFlat: json['lastUpdatedFlat'],
      createdAtFlat: json['CreatedAtFlat'],
      collectRentDate: json['CollectRenrDate'],
      realFloorsNum: json['RealfloorsNum'],
      samahDate: json['SamahDate'],
      rentTypeArab: json['RentTypeArab'],
      rentTypeEng: json['RentTypeEng'],
      aqar: json['Aqar'] != null ? AqarInfoModel.fromJson(json['Aqar']) : null,
      flatSpecs: (json['FlatSpecs'] as List<dynamic>?)
          ?.map((e) => FlatSpecs.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AqarInfoModel {
  final String? aqarID;
  final String? aqarName;
  final String? ownerID;
  final String? floarNum;
  final String? areaID;
  final String? goverID;
  final String? aqarPhoto;
  final String? status;
  final String? realFloorsNum;
  final String? lastUpdatedAqar;
  final String? createdAtAqar;
  final String? aqarLat;
  final String? aqarLongt;
  final String? employeeID;
  final String? aqarTypeID;

  AqarInfoModel({
    this.aqarID,
    this.aqarName,
    this.ownerID,
    this.floarNum,
    this.areaID,
    this.goverID,
    this.aqarPhoto,
    this.status,
    this.realFloorsNum,
    this.lastUpdatedAqar,
    this.createdAtAqar,
    this.aqarLat,
    this.aqarLongt,
    this.employeeID,
    this.aqarTypeID,
  });

  factory AqarInfoModel.fromJson(Map<String, dynamic> json) {
    return AqarInfoModel(
      aqarID: json['AqarID'],
      aqarName: json['AqarName'],
      ownerID: json['OwnerID'],
      floarNum: json['FloarNum'],
      areaID: json['AreaID'],
      goverID: json['GoverID'],
      aqarPhoto: json['AqarPhoto'],
      status: json['Status'],
      realFloorsNum: json['RealfloorsNum'],
      lastUpdatedAqar: json['lastUpdatedAqar'],
      createdAtAqar: json['CreatedAtAqar'],
      aqarLat: json['AqarLat'],
      aqarLongt: json['AqarLongt'],
      employeeID: json['EmployeeID'],
      aqarTypeID: json['AqarTypeID'],
    );
  }
}
class FlatSpecs {
  FlatSpecs({
    String? flatWithSpecID,
    String? flatID,
    String? flatTypesSpecificationID,
    String? value,
    String? flatTypesSpecificationArab,
    String? flatTypesSpecificationEng,
    String? flatTypesSpecificationStatus,
    String? flatTypesID,}){
    _flatWithSpecID = flatWithSpecID;
    _flatID = flatID;
    _flatTypesSpecificationID = flatTypesSpecificationID;
    _value = value;
    _flatTypesSpecificationArab = flatTypesSpecificationArab;
    _flatTypesSpecificationEng = flatTypesSpecificationEng;
    _flatTypesSpecificationStatus = flatTypesSpecificationStatus;
    _flatTypesID = flatTypesID;
  }

  FlatSpecs.fromJson(dynamic json) {
    _flatWithSpecID = json['FlatWithSpecID'];
    _flatID = json['FlatID'];
    _flatTypesSpecificationID = json['FlatTypesSpecificationID'];
    _value = json['Value'];
    _flatTypesSpecificationArab = json['FlatTypesSpecificationArab'];
    _flatTypesSpecificationEng = json['FlatTypesSpecificationEng'];
    _flatTypesSpecificationStatus = json['FlatTypesSpecificationStatus'];
    _flatTypesID = json['FlatTypesID'];
  }
  String? _flatWithSpecID;
  String? _flatID;
  String? _flatTypesSpecificationID;
  String? _value;
  String? _flatTypesSpecificationArab;
  String? _flatTypesSpecificationEng;
  String? _flatTypesSpecificationStatus;
  String? _flatTypesID;

  String? get flatWithSpecID => _flatWithSpecID;
  String? get flatID => _flatID;
  String? get flatTypesSpecificationID => _flatTypesSpecificationID;
  String? get value => _value;
  String? get flatTypesSpecificationArab => _flatTypesSpecificationArab;
  String? get flatTypesSpecificationEng => _flatTypesSpecificationEng;
  String? get flatTypesSpecificationStatus => _flatTypesSpecificationStatus;
  String? get flatTypesID => _flatTypesID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FlatWithSpecID'] = _flatWithSpecID;
    map['FlatID'] = _flatID;
    map['FlatTypesSpecificationID'] = _flatTypesSpecificationID;
    map['Value'] = _value;
    map['FlatTypesSpecificationArab'] = _flatTypesSpecificationArab;
    map['FlatTypesSpecificationEng'] = _flatTypesSpecificationEng;
    map['FlatTypesSpecificationStatus'] = _flatTypesSpecificationStatus;
    map['FlatTypesID'] = _flatTypesID;
    return map;
  }

}