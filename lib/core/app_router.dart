import 'package:flutter/material.dart';
import 'package:hr_manegement/core/strings_manager.dart';

/// SCREENS
import 'package:hr_manegement/features/auth/view/screens/login_screen.dart';
import 'package:hr_manegement/features/employee/data/models/branches_model.dart';
import 'package:hr_manegement/features/main_screen/view/screens/main_screen.dart';

import 'package:hr_manegement/features/holiday__requests/view/screens/holiday_screen.dart';
import 'package:hr_manegement/features/errand_requests/view/screens/errand_screen.dart';
import 'package:hr_manegement/features/loan__requests/view/screens/loan_screen.dart';
import 'package:hr_manegement/features/business_trip_requests/view/screens/business_trip_screen.dart';
import 'package:hr_manegement/features/permission_request/view/screens/permission_screen.dart';

import 'package:hr_manegement/features/reports/view/screens/reports_screen.dart';
import 'package:hr_manegement/features/profile/view/screens/profile_screen.dart';
import 'package:hr_manegement/features/notifications/view/screens/notifications_screen.dart';
import 'package:hr_manegement/features/employee/view/screens/branches_screen.dart';
import 'package:hr_manegement/features/employee/view/screens/employees_screen.dart';

import '../features/employee/view/screens/tracking_screen.dart';
import '../features/splash/splash_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String mainScreen = "/mainScreen";

  /// Requests
  static const String holidayRequest = "/holidayRequest";
  static const String errandRequest = "/errandRequest";
  static const String loanRequest = "/loanRequest";
  static const String businessTripRequest = "/businessTripRequest";
  static const String permissionRequest = "/permissionRequest";

  /// Other Screens
  static const String reports = "/reports";
  static const String profile = "/profile";
  static const String notifications = "/notifications";

  /// Employee Screens
  static const String employee = "/employee";
  static const String branchEmployees = "/branchEmployees";
  static const String tracking = "/tracking";
}

class AppRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      //splash
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// Login
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      /// Main Screen
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      /// Holiday Request
      case Routes.holidayRequest:
        return MaterialPageRoute(builder: (_) => const HolidayScreen());

      /// Mission Request
      case Routes.errandRequest:
        return MaterialPageRoute(builder: (_) => const ErrandScreen());

      /// Loan Request
      case Routes.loanRequest:
        return MaterialPageRoute(builder: (_) => const LoanScreen());

      /// Business Trip Request
      case Routes.businessTripRequest:
        return MaterialPageRoute(builder: (_) => const BusinessTripScreen());

      /// Permission Request
      case Routes.permissionRequest:
        return MaterialPageRoute(builder: (_) => const PermissionScreen());

      /// Reports
      case Routes.reports:
        return MaterialPageRoute(builder: (_) => const ReportsScreen());

      /// Profile
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      /// Notifications
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      /// Employee Screen
      case Routes.employee:
        return MaterialPageRoute(builder: (_) => const BranchesScreen());

      /// Branch Employees Screen
      case Routes.branchEmployees:
        final branch = settings.arguments as BrancheModel;
        return MaterialPageRoute(
          builder: (_) => EmployeesScreen(brancheModel: branch),
        );

      /// Tracking Screen
      case Routes.tracking:
        final employeeName = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => const TrackingScreen(),
          settings: RouteSettings(arguments: employeeName),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }

  static String getInitialRoute(String initialRoute) {
    return initialRoute;
  }
}
