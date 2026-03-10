import 'dart:io';

class EmployeeUpdateRequestModel {
  File? employeePhoto;
  String? empPhone;
  String? empKey;
  final String? employeeID;

  EmployeeUpdateRequestModel({
     this.employeePhoto,
     this.empPhone,
    this.empKey,
    required this.employeeID,
  });

  factory EmployeeUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return EmployeeUpdateRequestModel(
      employeePhoto: json['EmployeePhoto'],
      empPhone: json['EmpPhone'],
      empKey: json['EmpKey'],
      employeeID: json['EmployeeID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmployeePhoto': employeePhoto,
      'EmpPhone': empPhone,
      'EmpKey': empKey,
      'EmployeeID': employeeID,
    };
  }
  void printData() {
    print('EmployeeUpdateRequestModel {');
    print('  EmployeePhoto: ${employeePhoto?.path ?? "null"}');
    print('  EmpPhone: $empPhone');
    print('  EmpKey: $empKey');
    print('  EmployeeID: $employeeID');
    print('}');
  }

}
