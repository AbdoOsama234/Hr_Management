import 'dart:io';

class AddEmployeeModel {
  String? employeeName;

  String? token;
  File? employeePhoto;
  String? phoneNumber;
  String? phoneNumberKey;
  AddEmployeeModel(
      {required this.employeePhoto,
      required,
      required this.employeeName,
      required this.phoneNumber,
      required this.phoneNumberKey,
      required this.token,
      });
}
