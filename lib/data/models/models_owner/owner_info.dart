class QwnerModel {
  String? ownerID;

  String? ownerKey;

  String? ownerPhone;

  String? ownerFName;

  String? bankAccount;

  String? ownerLName;

  String? ownerEmail;

  String? ownerPhoto;

  String? firebaseToken;

  String? token;

  String? ownerStatus;

  String? lastUpdatedOwner;

  String? type;

  String? phone1;

  String? phone2;

  String? segalDariby;

  String? createdAtOwner;

  QwnerModel({
    this.type,
    this.phone1,
    this.phone2,
    this.segalDariby,
    this.bankAccount,
    this.ownerID,
    this.ownerKey,
    this.ownerPhone,
    this.ownerFName,
    this.ownerLName,
    this.ownerEmail,
    this.ownerPhoto,
    this.firebaseToken,
    this.token,
    this.ownerStatus,
    this.lastUpdatedOwner,
    this.createdAtOwner,
  });

  factory QwnerModel.fromJson(Map<String, dynamic> json) => QwnerModel(
    phone1: json['PHONE1'],
        phone2: json['PHONE2'],
        type: json['Type'],
        segalDariby: json['Segl'],
        ownerID: json['OwnerID'],
        ownerKey: json['OwnerKey'],
        ownerPhone: json['OwnerPhone'],
        ownerFName: json['OwnerFName'],
        ownerLName: json['OwnerLName'],
        bankAccount: json['BankAccount'],
        ownerEmail: json['OwnerEmail'],
        ownerPhoto: json['OwnerPhoto'],
        firebaseToken: json['FirebaseToken'],
        token: json['Token'],
        ownerStatus: json['OwnerStatus'],
        lastUpdatedOwner: json['lastUpdatedOwner'],
        createdAtOwner: json['CreatedAtOwner'],
      );

  Map<String, dynamic> toJson() => {
    'Segl':segalDariby,
    'PHONE1':phone1,
    'PHONE2':phone2,
    'Type':type,
        'OwnerID': ownerID,
        'OwnerKey': ownerKey,
        'OwnerPhone': ownerPhone,
        'OwnerFName': ownerFName,
        'OwnerLName': ownerLName,
        'OwnerEmail': ownerEmail,
        'OwnerPhoto': ownerPhoto,
        'FirebaseToken': firebaseToken,
        'Token': token,
        'OwnerStatus': ownerStatus,
        'lastUpdatedOwner': lastUpdatedOwner,
        'CreatedAtOwner': createdAtOwner,
        'BankAccount':bankAccount
      };

  bool get isEmpty {
    return (ownerID == null || ownerID!.isEmpty) &&
        (ownerPhone == null || ownerPhone!.isEmpty) &&
        (ownerEmail == null || ownerEmail!.isEmpty);
  }
}
