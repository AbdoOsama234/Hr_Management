class AddEmployeeToAqarRequestModel {
  final String aqarID;
  final String employeeID;

  AddEmployeeToAqarRequestModel({
    required this.aqarID,
    required this.employeeID,
  });

  // fromJson factory constructor
  factory AddEmployeeToAqarRequestModel.fromJson(Map<String, dynamic> json) {
    return AddEmployeeToAqarRequestModel(
      aqarID: json['AqarID'] ?? '',
      employeeID: json['EmployeeID'] ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'AqarID': aqarID,
      'EmployeeID': employeeID,
    };
  }

  @override
  String toString() {
    return 'AddEmployeeToAqarRequestModel(aqarID: $aqarID, employeeID: $employeeID)';
  }
}
