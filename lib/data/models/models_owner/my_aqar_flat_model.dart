class AqarFlatInfo {
  String? flatID;
  String? realfloorsNum;
  String? collectRenrDate;
  String? aqarID;
  String? samahDate;
  String? flatNum;
  String? flatTypesID;
  String? flatPhoto;
  String? flatStatus;
  String? rentStatus;
  String? rentPrice;
  String? rentType;
  String? lastUpdatedFlat;
  String? createdAtFlat;
  String? rentTypeArab;
  String? rentTypeEng;
  String? rentStates;
  List<FlatSpecs>? flatSpecs;
  String? flatTypeEng;
  String? flatTypeArab;
  AqarFlatInfo(
      {this.flatID,
      this.aqarID,
        this.samahDate,
      this.flatNum,
      this.rentStates,
      this.flatTypesID,
      this.flatPhoto,
      this.flatStatus,
      this.rentStatus,
      this.rentPrice,
      this.rentType,
      this.lastUpdatedFlat,
      this.createdAtFlat,
      this.collectRenrDate,
      this.rentTypeArab,
      this.rentTypeEng,
      this.flatSpecs,
        this.realfloorsNum,
        this.flatTypeArab,
        this.flatTypeEng
      });

  AqarFlatInfo.fromJson(Map<String, dynamic> json) {
    flatTypeArab = json['FlatTypesArab'];
    flatTypeEng = json['FlatTypesEng'];
    realfloorsNum = json['RealfloorsNum'];
    rentStates = json['RentStates'];
    flatID = json['FlatID'];
    aqarID = json['AqarID'];
    flatNum = json['FlatNum'];
    flatTypesID = json['FlatTypesID'];
    flatPhoto = json['FlatPhoto'];
    flatStatus = json['FlatStatus'];
    samahDate = json['SamahDate'];
    rentStatus = json['RentStatus'];
    rentPrice = json['RentPrice'];
    rentType = json['RentType'];
    lastUpdatedFlat = json['lastUpdatedFlat'];
    createdAtFlat = json['CreatedAtFlat'];
    collectRenrDate = json['CollectRenrDate'];
    rentTypeArab = json['RentTypeArab'];
    rentTypeEng = json['RentTypeEng'];
    if (json['FlatSpecs'] != null) {
      flatSpecs = <FlatSpecs>[];
      json['FlatSpecs'].forEach((v) {
        flatSpecs!.add(FlatSpecs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FlatID'] = flatID;
    data['AqarID'] = aqarID;
    data['SamahDate'] = samahDate;
    data['FlatNum'] = flatNum;
    data['FlatTypesID'] = flatTypesID;
    data['FlatPhoto'] = flatPhoto;
    data['FlatStatus'] = flatStatus;
    data['RentStatus'] = rentStatus;
    data['RentPrice'] = rentPrice;
    data['RentType'] = rentType;
    data['lastUpdatedFlat'] = lastUpdatedFlat;
    data['CreatedAtFlat'] = createdAtFlat;
    data['CollectRenrDate'] = collectRenrDate;
    data['RentTypeArab'] = rentTypeArab;
    data['RentTypeEng'] = rentTypeEng;
    data['RealfloorsNum'] = realfloorsNum;
    data['FlatTypesArab'] = flatTypeArab;
    data['FlatTypesEng'] = flatTypeEng;
    if (flatSpecs != null) {
      data['FlatSpecs'] = flatSpecs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlatSpecs {
  String? flatWithSpecID;
  String? flatID;
  String? flatTypesSpecificationID;
  String? value;
  String? flatTypesSpecificationArab;
  String? flatTypesSpecificationEng;
  String? flatTypesSpecificationStatus;
  String? flatTypesID;

  FlatSpecs(
      {this.flatWithSpecID,
      this.flatID,
      this.flatTypesSpecificationID,
      this.value,
      this.flatTypesSpecificationArab,
      this.flatTypesSpecificationEng,
      this.flatTypesSpecificationStatus,
      this.flatTypesID});

  FlatSpecs.fromJson(Map<String, dynamic> json) {
    flatWithSpecID = json['FlatWithSpecID'];
    flatID = json['FlatID'];
    flatTypesSpecificationID = json['FlatTypesSpecificationID'];
    value = json['Value'];
    flatTypesSpecificationArab = json['FlatTypesSpecificationArab'];
    flatTypesSpecificationEng = json['FlatTypesSpecificationEng'];
    flatTypesSpecificationStatus = json['FlatTypesSpecificationStatus'];
    flatTypesID = json['FlatTypesID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FlatWithSpecID'] = flatWithSpecID;
    data['FlatID'] = flatID;
    data['FlatTypesSpecificationID'] = flatTypesSpecificationID;
    data['Value'] = value;
    data['FlatTypesSpecificationArab'] = flatTypesSpecificationArab;
    data['FlatTypesSpecificationEng'] = flatTypesSpecificationEng;
    data['FlatTypesSpecificationStatus'] = flatTypesSpecificationStatus;
    data['FlatTypesID'] = flatTypesID;
    return data;
  }
}

// /// status_code : 200
// /// success : true
// /// data : [{"FlatID":"2","AqarID":"1","FlatNum":"14","FlatTypesID":"1","FlatPhoto":"https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-655771.png","FlatStatus":"ACTIVE","RentStatus":"NO","RentPrice":"200","lastUpdatedFlat":"2025-06-14 16:20:33","CreatedAtFlat":"2025-06-14 15:50:02","FlatSpecs":[{"FlatWithSpecID":"10","FlatID":"2","FlatTypesSpecificationID":"1","Value":"5","FlatTypesSpecificationArab":"مساحة","FlatTypesSpecificationEng":"Distance","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"},{"FlatWithSpecID":"11","FlatID":"2","FlatTypesSpecificationID":"4","Value":"230","FlatTypesSpecificationArab":"عدد الحجرات","FlatTypesSpecificationEng":"Number of rooms","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"}]}]
// /// message : "sucssesfully"

class MyAqarFlatModel {
  MyAqarFlatModel({
    num? statusCode,
    bool? success,
    String? money,
    List<AqarFlatInfo>? data,
    String? message,
  }) {
    _statusCode = statusCode;
    _success = success;
    _data = data;
    _message = message;
  }

  MyAqarFlatModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _success = json['success'];
    _money = json['money'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AqarFlatInfo.fromJson(v));
      });
    }
    _message = json['message'];
  }
  String? _money;
  num? _statusCode;
  bool? _success;
  List<AqarFlatInfo>? _data;
  String? _message;

  String? get money => _money;
  num? get statusCode => _statusCode;
  bool? get success => _success;
  List<AqarFlatInfo>? get data => _data;
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

// /// FlatID : "2"
// /// AqarID : "1"
// /// FlatNum : "14"
// /// FlatTypesID : "1"
// /// FlatPhoto : "https://engaztechnology.net/aqaratyAPI/Owner/CompanyLogoImages/CompanyLogoImages-655771.png"
// /// FlatStatus : "ACTIVE"
// /// RentStatus : "NO"
// /// RentPrice : "200"
// /// lastUpdatedFlat : "2025-06-14 16:20:33"
// /// CreatedAtFlat : "2025-06-14 15:50:02"
// /// FlatSpecs : [{"FlatWithSpecID":"10","FlatID":"2","FlatTypesSpecificationID":"1","Value":"5","FlatTypesSpecificationArab":"مساحة","FlatTypesSpecificationEng":"Distance","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"},{"FlatWithSpecID":"11","FlatID":"2","FlatTypesSpecificationID":"4","Value":"230","FlatTypesSpecificationArab":"عدد الحجرات","FlatTypesSpecificationEng":"Number of rooms","FlatTypesSpecificationStatus":"ACTIVE","FlatTypesID":"1"}]

// class AqarFlatInfo {
//   AqarFlatInfo({
//     String? rentType,
//       String? flatID, 
//       String? aqarID, 
//       String? flatNum, 
//       String? flatTypesID, 
//       String? flatPhoto, 
//       String? flatStatus, 
//       String? rentStatus, 
//       String? rentPrice, 
//       String? lastUpdatedFlat, 
//       String? createdAtFlat,
//       String ?CollectRenrDate,
//        String ?RentTypeEng,
//        String ?RentTypeArab,
      
//       List<FlatSpecs>? flatSpecs,}){
//     _flatID = flatID;
//     _rentType = rentType;
//     _aqarID = aqarID;
//     _flatNum = flatNum;
//     _flatTypesID = flatTypesID;
//     _flatPhoto = flatPhoto;
//     _flatStatus = flatStatus;
//     _rentStatus = rentStatus;
//     _rentPrice = rentPrice;
//     _lastUpdatedFlat = lastUpdatedFlat;
//     _createdAtFlat = createdAtFlat;
//     _flatSpecs = flatSpecs;

// }

//   AqarFlatInfo.fromJson(dynamic json) {
//     _rentType = json['RentType'];
//     _flatID = json['FlatID'];
//     _aqarID = json['AqarID'];
//     _flatNum = json['FlatNum'];
//     _flatTypesID = json['FlatTypesID'];
//     _flatPhoto = json['FlatPhoto'];
//     _flatStatus = json['FlatStatus'];
//     _rentStatus = json['RentStatus'];
//     _rentPrice = json['RentPrice'];
//     _lastUpdatedFlat = json['lastUpdatedFlat'];
//     _createdAtFlat = json['CreatedAtFlat'];
//     if (json['FlatSpecs'] != null) {
//       _flatSpecs = [];
//       json['FlatSpecs'].forEach((v) {
//         _flatSpecs?.add(FlatSpecs.fromJson(v));
//       });
//     }
//   }
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

//   String? get rentType => _rentType;
//   String? get flatID => _flatID;
//   String? get aqarID => _aqarID;
//   String? get flatNum => _flatNum;
//   String? get flatTypesID => _flatTypesID;
//   String? get flatPhoto => _flatPhoto;
//   String? get flatStatus => _flatStatus;
//   String? get rentStatus => _rentStatus;
//   String? get rentPrice => _rentPrice;
//   String? get lastUpdatedFlat => _lastUpdatedFlat;
//   String? get createdAtFlat => _createdAtFlat;
//   List<FlatSpecs>? get flatSpecs => _flatSpecs;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['FlatID'] = _flatID;
//     map['AqarID'] = _aqarID;
//     map['FlatNum'] = _flatNum;
//     map['RentType'] = _rentType;
//     map['FlatTypesID'] = _flatTypesID;
//     map['FlatPhoto'] = _flatPhoto;
//     map['FlatStatus'] = _flatStatus;
//     map['RentStatus'] = _rentStatus;
//     map['RentPrice'] = _rentPrice;
//     map['lastUpdatedFlat'] = _lastUpdatedFlat;
//     map['CreatedAtFlat'] = _createdAtFlat;
//     if (_flatSpecs != null) {
//       map['FlatSpecs'] = _flatSpecs?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

// /// FlatWithSpecID : "10"
// /// FlatID : "2"
// /// FlatTypesSpecificationID : "1"
// /// Value : "5"
// /// FlatTypesSpecificationArab : "مساحة"
// /// FlatTypesSpecificationEng : "Distance"
// /// FlatTypesSpecificationStatus : "ACTIVE"
// /// FlatTypesID : "1"

// class FlatSpecs {
//   FlatSpecs({
//       String? flatWithSpecID, 
//       String? flatID, 
//       String? flatTypesSpecificationID, 
//       String? value, 
//       String? flatTypesSpecificationArab, 
//       String? flatTypesSpecificationEng, 
//       String? flatTypesSpecificationStatus, 
//       String? flatTypesID,}){
//     _flatWithSpecID = flatWithSpecID;
//     _flatID = flatID;
//     _flatTypesSpecificationID = flatTypesSpecificationID;
//     _value = value;
//     _flatTypesSpecificationArab = flatTypesSpecificationArab;
//     _flatTypesSpecificationEng = flatTypesSpecificationEng;
//     _flatTypesSpecificationStatus = flatTypesSpecificationStatus;
//     _flatTypesID = flatTypesID;
// }

//   FlatSpecs.fromJson(dynamic json) {
//     _flatWithSpecID = json['FlatWithSpecID'];
//     _flatID = json['FlatID'];
//     _flatTypesSpecificationID = json['FlatTypesSpecificationID'];
//     _value = json['Value'];
//     _flatTypesSpecificationArab = json['FlatTypesSpecificationArab'];
//     _flatTypesSpecificationEng = json['FlatTypesSpecificationEng'];
//     _flatTypesSpecificationStatus = json['FlatTypesSpecificationStatus'];
//     _flatTypesID = json['FlatTypesID'];
//   }
//   String? _flatWithSpecID;
//   String? _flatID;
//   String? _flatTypesSpecificationID;
//   String? _value;
//   String? _flatTypesSpecificationArab;
//   String? _flatTypesSpecificationEng;
//   String? _flatTypesSpecificationStatus;
//   String? _flatTypesID;

//   String? get flatWithSpecID => _flatWithSpecID;
//   String? get flatID => _flatID;
//   String? get flatTypesSpecificationID => _flatTypesSpecificationID;
//   String? get value => _value;
//   String? get flatTypesSpecificationArab => _flatTypesSpecificationArab;
//   String? get flatTypesSpecificationEng => _flatTypesSpecificationEng;
//   String? get flatTypesSpecificationStatus => _flatTypesSpecificationStatus;
//   String? get flatTypesID => _flatTypesID;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['FlatWithSpecID'] = _flatWithSpecID;
//     map['FlatID'] = _flatID;
//     map['FlatTypesSpecificationID'] = _flatTypesSpecificationID;
//     map['Value'] = _value;
//     map['FlatTypesSpecificationArab'] = _flatTypesSpecificationArab;
//     map['FlatTypesSpecificationEng'] = _flatTypesSpecificationEng;
//     map['FlatTypesSpecificationStatus'] = _flatTypesSpecificationStatus;
//     map['FlatTypesID'] = _flatTypesID;
//     return map;
//   }

// }