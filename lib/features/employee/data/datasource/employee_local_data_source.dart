import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../models/employee_model.dart';

abstract class EmployeeLocalDataSource {
  Future<List<EmployeeModel>> getEmployees();
}

@injectable
@Order(-1) // Ensure it's available for repository
class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  @override
  Future<List<EmployeeModel>> getEmployees() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      /// 📍 Riyadh Branch
      EmployeeModel(id: 1, name: "Ahmed Salah", position: "Software Engineer", branch: "branch_riyadh".tr(),),
      EmployeeModel(id: 2, name: "Fhad Al-Otaibi", position: "HR Manager", branch: "branch_riyadh".tr()),
      EmployeeModel(id: 3, name: "Sara Mohammed", position: "UI/UX Designer", branch: "branch_riyadh".tr()),
      EmployeeModel(id: 4, name: "Khalid Ibrahim", position: "Project Manager", branch: "branch_riyadh".tr()),
      EmployeeModel(id: 5, name: "Noura Abdullah", position: "Accountant", branch: "branch_riyadh".tr()),

      /// 📍 Jeddah Branch
      EmployeeModel(id: 6, name: "Omar Hassan", position: "Sales Director", branch: "branch_jeddah".tr()),
      EmployeeModel(id: 7, name: "Laila Ali", position: "Marketing Specialist", branch: "branch_jeddah".tr()),
      EmployeeModel(id: 8, name: "Mosaed Saeed", position: "Business Analyst", branch: "branch_jeddah".tr()),
      EmployeeModel(id: 9, name: "Hoda Mahmoud", position: "Operations Coordinator", branch: "branch_jeddah".tr()),

      /// 📍 Cairo Branch
      EmployeeModel(id: 10, name: "Abdelrahman Osama", position: "Flutter Developer", branch: "branch_cairo".tr()),
      EmployeeModel(id: 11, name: "Mona Ahmed", position: "Backend Developer", branch:  "branch_cairo".tr()),
      EmployeeModel(id: 12, name: "Mostafa Mahmoud", position: "QA Engineer", branch:  "branch_cairo".tr()),
      EmployeeModel(id: 13, name: "Dina Samir", position: "Content Creator", branch:  "branch_cairo".tr()),
      EmployeeModel(id: 14, name: "Tarek Ziad", position: "System Admin", branch:  "branch_cairo".tr()),

      /// 📍 Digital Tracks Branch
      EmployeeModel(id: 15, name: "Zaid Al-Harbi", position: "DevOps Engineer", branch: "branch_digital_tracks".tr()),
      EmployeeModel(id: 16, name: "Reem Al-Qahtani", position: "Data Scientist", branch: "branch_digital_tracks".tr()),
      EmployeeModel(id: 17, name: "Hassan Al-Zahrani", position: "Security Analyst", branch: "branch_digital_tracks".tr()),
      EmployeeModel(id: 18, name: "Ali Reda", position: "Cloud Architect", branch: "branch_digital_tracks".tr()),
      EmployeeModel(id: 19, name: "Fatima Zahra", position: "Fullstack Developer", branch: "branch_digital_tracks".tr()),
      EmployeeModel(id: 20, name: "Ibrahim Al-Fares", position: "Mobile Lead", branch: "branch_digital_tracks".tr()),
    ];
  }
}
