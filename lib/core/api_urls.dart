class ApiUrls {
  static const String baseUrl = "https://hala-cars.com";
  static const String baseApiUrl = "$baseUrl/api/";

  static String getImageLink(String image) {
    print("image $baseUrl/$image");
    return "$baseUrl/$image";
  }

  //Home Apis
  static const String allBranches = '${baseApiUrl}all-branches';
  static const String allUsers = '${baseApiUrl}all-users-branches';
  static const String businessTripRequest =
      '${baseApiUrl}business-trip-request';

  //AUTH APIS
  static const String login = 'login';
}
