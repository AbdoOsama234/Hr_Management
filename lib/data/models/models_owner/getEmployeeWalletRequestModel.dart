class GetEmployeeWalletRequestModel {
  final String employeeID;
  final String ownerPhone;
  final String ownerKey;

  GetEmployeeWalletRequestModel({
    required this.employeeID,
    required this.ownerPhone,
    required this.ownerKey,
  });

  factory GetEmployeeWalletRequestModel.fromJson(Map<String, dynamic> json) {
    return GetEmployeeWalletRequestModel(
      employeeID: json['EmployeeID'],
      ownerPhone: json['OwnerPhone'],
      ownerKey: json['OwnerKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmployeeID': employeeID,
      'OwnerPhone': ownerPhone,
      'OwnerKey': ownerKey,
    };
  }
}
