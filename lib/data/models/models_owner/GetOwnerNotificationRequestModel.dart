class GetOwnerNotificationRequestModel {
  final String ownerID;
  final String ownerPhone;
  final String ownerKey;

  GetOwnerNotificationRequestModel({
    required this.ownerID,
    required this.ownerPhone,
    required this.ownerKey,
  });

  factory GetOwnerNotificationRequestModel.fromJson(Map<String, dynamic> json) {
    return GetOwnerNotificationRequestModel(
      ownerID: json['OwnerID'],
      ownerPhone: json['OwnerPhone'],
      ownerKey: json['OwnerKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OwnerID': ownerID,
      'OwnerPhone': ownerPhone,
      'OwnerKey': ownerKey,
    };
  }
}
