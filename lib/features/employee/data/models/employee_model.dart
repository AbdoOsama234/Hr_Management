enum AttendanceStatus {
  present,
  absent,
}
class EmployeeModel {
  final int id;
  final String name;
  final String position;
  final String branch;



  EmployeeModel({
    required this.id,
    required this.name,
    required this.position,
    required this.branch,

  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'branch': branch,
    };
  }
}
