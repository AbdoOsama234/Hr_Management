class GetEmployeeFlatByAqarRequestModel {
  final String? employeeID;
  final String? aqarID;

  GetEmployeeFlatByAqarRequestModel({
    required this.employeeID,
    required this.aqarID,
  });

  factory GetEmployeeFlatByAqarRequestModel.fromJson(Map<String, dynamic> json) {
    return GetEmployeeFlatByAqarRequestModel(
      employeeID: json['EmployeeID'] ?? "",
      aqarID: json['AqarID'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmployeeID': employeeID,
      'AqarID': aqarID,
    };
  }
}
