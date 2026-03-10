// class OwnerInfoModel {
//   String? ownerID;
//
//   String? ownerKey;
//
//   String? ownerPhone;
//
//   String? ownerFName;
//
//   String? ownerLName;
//
//   String? ownerEmail;
//
//   String? ownerPhoto;
//
//   String? firebaseToken;
//
//   String? token;
//
//   String? ownerStatus;
//
//   String? lastUpdatedOwner;
//
//   String? createdAtOwner;
//
//   OwnerInfoModel({
//     this.ownerID,
//     this.ownerKey,
//     this.ownerPhone,
//     this.ownerFName,
//     this.ownerLName,
//     this.ownerEmail,
//     this.ownerPhoto,
//     this.firebaseToken,
//     this.token,
//     this.ownerStatus,
//     this.lastUpdatedOwner,
//     this.createdAtOwner,
//   });
//
//   factory OwnerInfoModel.fromJson(Map<String, dynamic> json) => OwnerInfoModel(
//         ownerID: json['OwnerID'],
//         ownerKey: json['OwnerKey'],
//         ownerPhone: json['OwnerPhone'],
//         ownerFName: json['OwnerFName'],
//         ownerLName: json['OwnerLName'],
//         ownerEmail: json['OwnerEmail'],
//         ownerPhoto: json['OwnerPhoto'],
//         firebaseToken: json['FirebaseToken'],
//         token: json['Token'],
//         ownerStatus: json['OwnerStatus'],
//         lastUpdatedOwner: json['lastUpdatedOwner'],
//         createdAtOwner: json['CreatedAtOwner'],
//       );
//
//   Map<String, dynamic> toJson() => {
//         'OwnerID': ownerID,
//         'OwnerKey': ownerKey,
//         'OwnerPhone': ownerPhone,
//         'OwnerFName': ownerFName,
//         'OwnerLName': ownerLName,
//         'OwnerEmail': ownerEmail,
//         'OwnerPhoto': ownerPhoto,
//         'FirebaseToken': firebaseToken,
//         'Token': token,
//         'OwnerStatus': ownerStatus,
//         'lastUpdatedOwner': lastUpdatedOwner,
//         'CreatedAtOwner': createdAtOwner,
//       };
//
//   bool get isEmpty {
//     return (ownerID == null || ownerID!.isEmpty) &&
//         (ownerPhone == null || ownerPhone!.isEmpty) &&
//         (ownerEmail == null || ownerEmail!.isEmpty);
//   }
// }
