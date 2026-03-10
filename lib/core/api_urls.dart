class ApiUrls {
  //static const String baseUrl = "https://dummyjson.com/";
  //static const String baseUrl = "https://engaztechnology.net/aqaratyAPI/Owner/";
  static const String baseUrl = "https://aqaratyapp.com/API/Owner/";
  //AUTH APIS
  static const String authBaseUrl = "${baseUrl}auth";
  static const String login = '${authBaseUrl}login';
  static const String register = '${authBaseUrl}register';
  static const String refreshToken = '${authBaseUrl}refresh-token';
  static const String logout = '${authBaseUrl}logout';
  static const String profile = '${authBaseUrl}profile';

  // upload image APIS
  static const String upload = "${authBaseUrl}upload/image";

  // tasks APIS
  static const String tasks = "${baseUrl}todos";

  // onBoarding APIS
  static const String onBoardingIntro = "${baseUrl}getIntro.php";

  // WhatsappOTP APIS
  static const String whatsappOTP = "${baseUrl}WhatsappOTP.php";

  // Check Phone APIS
  static const String checkPhone = "${baseUrl}CheckPhone.php";

  // SignUp User
  static const String signUpUser = "${baseUrl}SignUpUser.php";

  // get getMyAreas
  static const String getMyAreas = "${baseUrl}getMyAreas.php";

  // get get MyGover
  static const String getMyGover = "${baseUrl}getMyGover.php";

  // Add Aqar
  static const String addAqar = "${baseUrl}AddAqar.php";

  // get Aqars
  static const String getAqars = "${baseUrl}getMyAqars.php";

  // get CUSTOMER SERVICE
  static const String getCustomerService = "${baseUrl}getCustomerService.php";

  // get delete aqar
  static const String deleteAqar = "${baseUrl}DeleteAqar.php";

  // get aqars
  static const String getMyAqarFlat = "${baseUrl}getMyAqarFlat.php";

  static const String addRentalPrice = "${baseUrl}AddRentalPrice.php";

  static const String makeItSyana = "${baseUrl}MakeItSyana.php";

  static const String getMostagerFlats = "${baseUrl}getMostagerFlats.php";

  // get delete aqar
  static const String getFlatType = "${baseUrl}getFlatType.php";

  // get delete aqar
  static const String getSpecByType = "${baseUrl}getSpecByType.php";

  // get add flat
  static const String addFlat = "${baseUrl}AddFlat.php";

  // get edit aqar
  static const String editAqar = "${baseUrl}EditAqar.php";

  // get edit aqar
  static const String addEmployee = "${baseUrl}AddEmployee.php";

  static const String updateFlat = '${baseUrl}UpdateFlat.php';
  static const String deleteFlat = '${baseUrl}DeleteFlat.php';
  static const String getMyEmployees = '${baseUrl}getMyEmployees.php';
  static const String changeEmpStatus = '${baseUrl}ChangeEmpStatus.php';

  static const String changeEmpSalahyat = '${baseUrl}ChangeEmpSalahyat.php';

  static const String addEmployeeToFlat = '${baseUrl}AddEmployeeToFlat.php';
  static const String getFlatRentals = '${baseUrl}getFlatRentals.php';
  static const String getFlatCurrentEmployee =
      '${baseUrl}getFlatCurrentEmployee.php';
  static const String getFlatEmployees = '${baseUrl}getFlatEmployees.php';
  static const String getEmployeeFlat = '${baseUrl}getEmployeeFlat.php';
  static const String updateProfileDate = '${baseUrl}UpdateProfileDate.php';

  static const String getAqarType = '${baseUrl}getAqarType.php';

  static const String removeEmpFromAqar = '${baseUrl}RemoveEmpFromAqar.php';

  static const String getNotificationNotSeenCount =
      '${baseUrl}getNotificationNotSeenCount.php';

  static const String getTerms = '${baseUrl}getTerms.php';

  static const String getOwnerNotification =
      '${baseUrl}getOwnerNotification.php';

  static const String getEmployeeWallet = '${baseUrl}getEmployeeWallet.php';

  static const String getFlatWallet = '${baseUrl}getFlatWallet.php';

  static const String getMyEmployeesByName =
      '${baseUrl}getMyEmployeesByName.php';

  static const String getMyAqarsByName = '${baseUrl}getMyAqarsByName.php';

  static const String getFlatRentType = '${baseUrl}getFlatRentType.php';

  static const String getEmployeeWalletTotal =
      '${baseUrl}getEmployeeWalletTotal.php';

  static const String collectMoneyFromEmployee =
      '${baseUrl}CollectMoneyFromEmployee.php';

  static const String getAllMyFlats = '${baseUrl}getAllMyFlats.php';

  static const String addRental = '${baseUrl}AddRental.php';

  static const String getHomeStats = '${baseUrl}getHomeStats.php';

  static const String getAqarBakat = '${baseUrl}getAqarBakat.php';

  static const String getAllMyBills = '${baseUrl}getAllMyBills.php';

  static const String stopRental = '${baseUrl}StopRental.php';

  static const String addEmployeeToAqar = '${baseUrl}AddEmployeeToAqar.php';

  static const String contactUs = '${baseUrl}ContactUs.php';

  static const String getOwnerInfo = '${baseUrl}getOwnerInfo.php';

  static const String getRefuseResons = '${baseUrl}getRefuseResons.php';

  static const String uploadFile = '${baseUrl}UploadFile.php';

  static const String getAqarEmployees = '${baseUrl}getAqarEmployees.php';

  static const String getAqarPrices = '${baseUrl}getAqarPrices.php';

  static const String searchMostager = '${baseUrl}SearchMostager.php';

  static const String updateRental = '${baseUrl}UpdateRental.php';

  static const String removeEmpFromFlat = '${baseUrl}RemoveEmpFromFlat.php';

  static const String addMasrof = '${baseUrl}AddMasrof.php';

  static const String updateEshterak = '${baseUrl}UpdateEshterak.php';

  static const String checkPromo = '${baseUrl}CheckPromo.php';
  static const String canPay = "${baseUrl}CanPay.php";
  static const String needUpdate = "${baseUrl}needUpdate.php";
}

class ApiUrlsEmployeeApp {
  static const String baseUrl = "https://aqaratyapp.com/API/Employee/";

  static const String baseUrlOwner = "https://aqaratyapp.com/API/Owner/";

  static const String whatsappOTP = "${baseUrl}WhatsappOTP.php";

  static const String checkPhone = "${baseUrl}CheckPhone.php";

  static const String getEmployeeFlat = "${baseUrl}getEmployeeFlat.php";

  static const String getMostagerFlats = "${baseUrl}getMostagerFlats.php";

  static const String makeItSyana = "${baseUrl}MakeItSyana.php";

  static const String searchMostager = "${baseUrl}SearchMostager.php";

  static const String getFlatRentals = "${baseUrl}getFlatRentals.php";

  static const String addRental = "${baseUrl}AddRental.php";

  static const String addRentalPrice = "${baseUrl}AddRentalPrice.php";

  static const String stopRental = "${baseUrl}StopRental.php";

  static const String getTerms = "${baseUrl}getTerms.php";

  static const String updateProfile = "${baseUrl}UpdateProfileDate.php";

  static const String getEmployeeWallet = "${baseUrl}getEmployeeWallet.php";

  static const String getEmployeeNotification =
      "${baseUrl}getEmployeeNotification.php";

  static const String getNotificationNotSeenCount =
      "${baseUrl}getNotificationNotSeenCount.php";

  static const String getFlatRentType = "${baseUrlOwner}getFlatRentType.php";

  static const String getFlatWallet = "${baseUrl}getFlatWallet.php";

  static const String getFlatType = "${baseUrlOwner}getFlatType.php";

  static const String sendMessage = "${baseUrl}SendMessage.php";

  static const String updateRental = "${baseUrl}UpdateRental.php";

  static const String getEmployeeFlatByAqar =
      "${baseUrl}getEmployeeFlatByAqar.php";
}
