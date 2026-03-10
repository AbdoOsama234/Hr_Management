class RemoveEmpFromFlatRequestModel {
  final String flatID;
  final String employeeID;

  RemoveEmpFromFlatRequestModel({
    required this.flatID,
    required this.employeeID,
  });

  factory RemoveEmpFromFlatRequestModel.fromJson(Map<String, dynamic> json) {
    return RemoveEmpFromFlatRequestModel(
      flatID: json['FlatID'] ?? '',
      employeeID: json['EmployeeID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FlatID': flatID,
      'EmployeeID': employeeID,
    };
  }
}
