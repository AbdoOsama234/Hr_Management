class EmployeeModel {

  String? employeeID;
  String? employeeName;
  String? employeePhoto;
  String? ownerID;
  String? employeeStatus;
  String? canDeleteMost;
  String? canEditMost;
  String? empKey;
  String? empPhone;
  String? token;
  String? firebaseToken;
  String? balance;
  String? startDate;
  String? endDate;
  String? createdAtEmployee;
  String? employeeAndFlatStatus;

  EmployeeModel({
    this.canEditMost,
    this.canDeleteMost,
    this.employeeID,
    this.employeeAndFlatStatus,
    this.createdAtEmployee,
    this.employeeName,
    this.employeePhoto,
    this.ownerID,
    this.employeeStatus,
    this.empKey,
    this.empPhone,
    this.token,
    this.firebaseToken,
    this.balance,
    this.startDate,
    this.endDate,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    canEditMost = json['CanUpdateMost'];
    canDeleteMost = json['CanDeleteMost'];
    employeeAndFlatStatus = json['EmployeeAndFlatStatus'];
    createdAtEmployee = json['CreatedAtEmployee'];
    startDate = json['CreatedAtEmployeeAndFlat'];
    endDate = json['lastUpdatedEmployeeAndFlat'];
    employeeID = json['EmployeeID'];
    employeeName = json['EmployeeName'];
    employeePhoto = json['EmployeePhoto'];
    ownerID = json['OwnerID'];
    employeeStatus = json['EmployeeStatus'];
    empKey = json['EmpKey'];
    empPhone = json['EmpPhone'];
    token = json['Token'];
    firebaseToken = json['FirebaseToken'];
    balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CanUpdateMost'] = canEditMost;
    data['CanDeleteMost'] = canDeleteMost;
    data['EmployeeID'] = employeeID;
    data['EmployeeName'] = employeeName;
    data['EmployeePhoto'] = employeePhoto;
    data['OwnerID'] = ownerID;
    data['EmployeeStatus'] = employeeStatus;
    data['EmpKey'] = empKey;
    data['EmpPhone'] = empPhone;
    data['Token'] = token;
    data['FirebaseToken'] = firebaseToken;
    data['Balance'] = balance;
    return data;
  }
}
