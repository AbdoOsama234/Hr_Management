class RemoveEmpFromAqarRequestModel {
  final String aqarID;
  final String employeeID;

  RemoveEmpFromAqarRequestModel({
    required this.aqarID,
    required this.employeeID,
  });

  factory RemoveEmpFromAqarRequestModel.fromJson(Map<String, dynamic> json) {
    return RemoveEmpFromAqarRequestModel(
      aqarID: json['AqarID'] ?? '',
      employeeID: json['EmployeeID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AqarID': aqarID,
      'EmployeeID': employeeID,
    };
  }
}