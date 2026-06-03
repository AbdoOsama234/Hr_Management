class ApiUrls {
  static const String baseUrl = "https://hala-cars.com";
  static const String baseApiUrl = "$baseUrl/api/";

  static String getImageLink(String image) {
    print("image $baseUrl/$image");
    return "$baseUrl/$image";
  }

  //requests Apis
  static const String allBranches = '${baseApiUrl}all-branches';
  static const String allUsers = '${baseApiUrl}all-users-branches';
  static const String businessTripRequest =
      '${baseApiUrl}business-trip-request';
  static const String errandRequests = '${baseApiUrl}missions-request';
  static const String holidayRequests = '${baseApiUrl}vacation-request';
  static const String loanRequests = '${baseApiUrl}loans-request';
  static const String permissionRequest = '${baseApiUrl}permissions-request';
  static const String tasks = '${baseApiUrl}tasks';

  ///dashboard
  static const String employeeAttendance = '${baseApiUrl}employee-attendance';
  static const String instructions = '${baseApiUrl}instructions/';



  //AUTH APIS
  static const String login = 'login';
}
