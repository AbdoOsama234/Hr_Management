class CollectMoneyFromEmployeeRequestModel {
  final String balance;
  final String employeeID;
  final String ownerPhone;
  final String ownerKey;

  CollectMoneyFromEmployeeRequestModel({
    required this.balance,
    required this.employeeID,
    required this.ownerPhone,
    required this.ownerKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'Balance': balance,
      'EmployeeID': employeeID,
      'OwnerPhone': ownerPhone,
      'OwnerKey': ownerKey,
    };
  }

  factory CollectMoneyFromEmployeeRequestModel.fromJson(Map<String, dynamic> json) {
    return CollectMoneyFromEmployeeRequestModel(
      balance: json['Balance'] ?? '',
      employeeID: json['EmployeeID'] ?? '',
      ownerPhone: json['OwnerPhone'] ?? '',
      ownerKey: json['OwnerKey'] ?? '',
    );
  }
}
