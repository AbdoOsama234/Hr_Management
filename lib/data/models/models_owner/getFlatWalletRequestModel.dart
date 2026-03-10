class GetFlatWalletRequestModel {
  final String flatID;
  final String ownerPhone;
  final String ownerKey;
  String? startDate;
  String? endDate;

  GetFlatWalletRequestModel({
    required this.flatID,
    required this.ownerPhone,
    required this.ownerKey,
    this.startDate,
    this.endDate,
  });

  factory GetFlatWalletRequestModel.fromJson(Map<String, dynamic> json) {
    return GetFlatWalletRequestModel(
      flatID: json['FlatID'],
      ownerPhone: json['OwnerPhone'],
      ownerKey: json['OwnerKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FlatID': flatID,
      'OwnerPhone': ownerPhone,
      'OwnerKey': ownerKey,
      if (startDate != null) 'DateeStart': startDate,
      if (endDate != null) 'DateeEnd': endDate
    };
  }
}
